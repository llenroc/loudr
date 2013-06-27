define ["marionette"], (Marionette) ->

  LoudrAuth = Backbone.Model.extend
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
          cb json.success
        error: (err, blah, doh) ->
          console.log err, blah, doh

  return LoudrAuth