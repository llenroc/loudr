express = require "express"
http = require "http"
path = require "path"
routes = require "./app/routes"
config = require "./config"

RedisStore = require("connect-redis")(express)

# Create the app variable
app = express()

# all environments
app.set "port", process.env.PORT or process.env.OPENSHIFT_INTERNAL_PORT or 3000
app.set "views", __dirname + "/app/views"
app.set "view engine", "ejs"

app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.session

  secret: "s3cr3ts3cr3t1v3g0t4s3cr3t"
  store: new RedisStore config.settings.redis

app.use app.router
app.use express.static path.join(__dirname, "app/static")

# development only
app.use express.errorHandler()  if "development" is app.get("env")

routes.add app

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")