require "kemal"

require "../marathons/marathons.cr"

require "./views/**"
require "./controllers/**"
require "./router.cr"


Kemal.run
