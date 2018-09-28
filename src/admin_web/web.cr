require "crinja"
require "dotenv"
require "kemal"

Dotenv.load

require "../marathons/marathons.cr"

require "./util/**"
require "./handlers/**"
require "./controllers/**"
require "./router.cr"

ADMIN_WEB_PORT = ENV["ADMIN_WEB_PORT"].to_i

add_handler(SessionHandler.new)
add_handler(AuthenticationHandler.new)

Kemal.run(port: ADMIN_WEB_PORT)
