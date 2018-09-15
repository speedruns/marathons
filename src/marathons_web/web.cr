require "crinja"
require "kemal"

require "../marathons/marathons.cr"

require "./util/**"
require "./views/**"
require "./controllers/**"
require "./router.cr"


Kemal.run
