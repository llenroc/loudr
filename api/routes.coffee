# This file maps your route matches
# to functions defined in various
# controller classes
exports.add = (server) ->
  # Define Controllers
  site_controller = require './controllers/site'
  user_controller = require './controllers/user'
  project_controller = require './controllers/project'

  # Define Routes
  server.get '/', site_controller.index

  # Authing
  server.get '/authed', user_controller.authed
  server.post '/auth/login', user_controller.login
  server.get '/auth/logout', user_controller.logout

  # User Routes
  server.get '/user/:email', user_controller.get_user
  server.post '/user', user_controller.create_user
  server.put '/user/:id', user_controller.update_user
  server.del '/user/:id', user_controller.delete_user
  server.get '/user/create/gerald/account', user_controller.create_gerald_account

  # Projects
  server.get '/project', project_controller.get_all
  server.get '/project/:id', project_controller.get_by_id
  server.post '/project', project_controller.create_project
  server.put '/project/:id', project_controller.update_project
  server.del '/project/confirm/:id', project_controller.delete_project
  server.del '/project/:id', project_controller.disable_project
  server.del '/project/delete/:id', project_controller.delete_project