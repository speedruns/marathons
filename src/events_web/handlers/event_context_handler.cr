require "http"

class EventContextHandler
  include HTTP::Handler

  def call(env : HTTP::Server::Context)
    call_next(env)
  end
end
