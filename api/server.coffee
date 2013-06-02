# restify = require "restify"
express = require "express"
mongoose = require "mongoose"
routes = require "./routes"
config = require "../config"

RedisStore = require("connect-redis")(express)
# redis = require("redis").createClient()

server = express()
server.use express.bodyParser()
server.use express.cookieParser()
server.use express.session
  secret: "s3cr3ts3cr3t1v3g0t4s3cr3t"
  store: new RedisStore
    host: 'localhost'
    port: 6379
    #client: redis

db = mongoose.connect config.settings.conn_str
  # , (err) ->
  # mongoose.connection.db.dropDatabase (err) ->
  #   console.log 'DropDB Error:', err if err?

mongoose.connection.on "error", (errorObject) ->
  console.log 'Connection Error:', errorObject

Schema = mongoose.Schema

# Add Routes
routes.add server

server.listen 3001, ->
  console.log "%s listening at %s", server.name, server.url