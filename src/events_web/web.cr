require "crinja"
require "dotenv"
require "orion"

Dotenv.load


require "../marathons/marathons.cr"

require "./router.cr"
require "./util/**"
require "./controllers/**"
require "./handlers/**"

EVENTS_WEB_PORT = ENV["EVENTS_WEB_PORT"].to_i

puts "EventsWeb is running on port #{EVENTS_WEB_PORT}"
EventsWebRouter.listen(port: EVENTS_WEB_PORT)
