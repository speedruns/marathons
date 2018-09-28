require "http"

class HTTP::Server::Context
  property! event : Events::Event
end

class EventContextHandler
  include HTTP::Handler

  def call(conn : HTTP::Server::Context)
    unless evt = resolve_event_context(conn)
      puts evt
      Template.render(conn, "errors/404.html.j2", {
        "resource" => conn.request.resource
      })
      return
    end

    conn.event = evt
    call_next(conn)
  end

  private def resolve_event_context(conn)
    host = conn.request.host
    return unless host

    if idx = host.rindex('.')
      subdomain = host[0...idx]
      Events.get_event_for_subdomain(subdomain)
    else
      nil
    end
  end
end
