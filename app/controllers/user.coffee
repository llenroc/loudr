api_proxy = require "../api_proxy"

exports.register = (req, res) ->
  post_data = 
    form:
      full_name: req.body.full_name
      email: req.body.email
      password: req.body.password

  api_proxy.post '/user', post_data, false, (err, resp, json) ->
    console.log 'error: ', err
    res.send 'error' if err?

    json = JSON.parse json
    
    # Log them in...
    req.session.user = json.user if json.success?

    res.send json

exports.login = (req, res) ->
  post_data = 
    form:
      email: req.body.email
      password: req.body.password

  api_proxy.post '/auth/login', post_data, false, (err, resp, json) ->
    res.send 'error' if err

    json = JSON.parse json
    
    # Log them in...
    req.session.user = json.user if json.success?

    res.send json

exports.logout = (req, res) ->
  delete req.session.user

  return res.send
    success: true