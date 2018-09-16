require "crinja"
require "kemal"

require "../marathons/marathons.cr"

require "./util/**"
require "./controllers/**"
require "./router.cr"

Kemal.run(port: 3001)
