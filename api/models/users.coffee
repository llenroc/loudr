mongoose = require("mongoose")
bcrypt = require("bcrypt")

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

SALT_WORK_FACTOR = 10

UserSchema = new Schema(
  user_id:
    type: ObjectId
    turnOn: true
  
  email:
    type: String
    required: true
    index:
      unique: true

  first_name:
    type: String

  last_name:
    type: String

  password:
    type: String
    required: true

  loginAttempts:
    type: Number
    required: true
    default: 0
  
  locked:
    type: Boolean
    default: false
)

UserSchema.pre 'save', (next) ->
  user = this
  return next() unless user.isModified("password")

  # generate a salt
  bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
    return next(err) if err
    bcrypt.hash user.password, salt, (err, hash) ->
      return next(err) if err
      user.password = hash
      next()

UserSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, @password, (err, isMatch) ->
    return cb(err) if err
    cb null, isMatch

UserSchema.virtual('full_name').get () ->
  return @.first_name + ' ' + @.last_name

UserSchema.methods.toJson = () ->
  user_obj =
    email: @.email
    name: @.full_name
    loginAttempts: @.loginAttempts
    locked: @.locked

  return user_obj

UserSchema.methods.incLoginAttempts = (cb) ->
  updates = $inc:
    loginAttempts: 1

  # lock the account if we've reached max attempts and it's not locked already
  updates.$set = locked: (@loginAttempts + 1 >= MAX_LOGIN_ATTEMPTS and not @locked)
  @update updates, cb

reasons = UserSchema.statics.failedLogin = 
  NOT_FOUND: 0
  PASSWORD_INCORRECT: 1
  MAX_ATTEMPTS: 5

UserSchema.statics.getAuthenticated = (email, password, cb) ->
  @findOne
    email: email
  , (err, user) ->
    return cb(err) if err
    return cb(null, null, reasons.NOT_FOUND)  unless user
    if user.locked
      return user.incLoginAttempts((err) ->
        return cb(err) if err
        cb null, null, reasons.MAX_ATTEMPTS
      )
    user.comparePassword password, (err, isMatch) ->
      return cb(err) if err
      if isMatch
        return cb(null, user) if not user.loginAttempts and not user.lockUntil
        updates =
          $set:
            loginAttempts: 0

          $unset:
            lockUntil: 1

        return user.update(updates, (err) ->
          return cb(err) if err
          cb null, user
        )
      user.incLoginAttempts (err) ->
        return cb(err) if err
        cb null, null, reasons.PASSWORD_INCORRECT

module.exports = mongoose.model('User', UserSchema)