require "http"

# A middleware for ensuring that a user has permissions to access a component
# of the application. This handler assumes that `conn.current_user` exists
# (e.g., AuthenticationHandler should be placed _before_ this handler).
class AuthorizationHandler
  include HTTP::Handler
  include EventsWebRouter::Helpers

  def initialize(@required_level = :organizer)
  end

  def call(conn : HTTP::Server::Context)
    passed =
      case @required_level
      when :organizer
        conn.current_user_is_organizer?
      else
        false
      end

    unless passed
      conn.response.headers.add "Location", login_path(redirect: conn.request.path)
      conn.response.status_code = 302
      return
    end

    call_next(conn)
  end
end
