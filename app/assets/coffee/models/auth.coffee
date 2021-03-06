define ["marionette"], (Marionette) ->

  class LoudrAuth extends Backbone.Model
    login: (email, password, cb) ->
      # $this = @
      $.ajax
        url: '/login',
        data:
          email: email
          password: password
        type: 'POST',
        dataType: 'json',
        success: (json) ->
          # if json.success
          # else
          # Aww shit son, you messed up

          cb json.success
        error: (err, blah, doh) ->
          console.log err, blah, doh
    logout: (cb) ->
      $.ajax
        url: '/logout',
        type: 'GET',
        dataType: 'json',
        success: (json) ->
          cb()
        error: (err, blah, doh) ->
          console.log err, blah, doh

    register: (full_name, email, password, cb) ->
      $.ajax
        url: '/register',
        data:
          full_name: full_name
          email: email
          password: password
        type: 'POST',
        dataType: 'json',
        success: (json) ->
          # if json.success
          # else
          # Aww shit son, you messed up

          cb json.success
        error: (err, blah, doh) ->
          console.log err, blah, doh
      
  return LoudrAuth