require "crinja"
require "orion"

require "../marathons/marathons.cr"

require "./util/**"
require "./controllers/**"
require "./handlers/**"
require "./router.cr"

PORT = 3000

puts "EventsWeb is running on port #{PORT}"
EventsWebRouter.listen(port: PORT)
