require "crinja"
require "kemal"

require "../marathons/marathons.cr"

require "./util/**"
require "./handlers/**"
require "./controllers/**"
require "./router.cr"

add_handler(SessionHandler.new)
add_handler(AuthenticationHandler.new)

Kemal.run(port: 3001)
