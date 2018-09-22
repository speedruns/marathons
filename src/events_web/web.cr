require "crinja"
require "orion"

require "../marathons/marathons.cr"

require "./router.cr"
require "./util/**"
require "./controllers/**"
require "./handlers/**"

PORT = 3000

puts "EventsWeb is running on port #{PORT}"
EventsWebRouter.listen(port: PORT)
