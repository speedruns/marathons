require "http"

# A middleware for ensuring that a user is logged in. This handler does NOT
# perform authorization or handling of permissions.
#
# If a user is not logged in, they will be redirected to the login page with
# a callback to bring them back to the originally-requested route.
class AuthenticationHandler
  include HTTP::Handler

  def call(conn : HTTP::Server::Context)
    unless conn.current_user? || conn.request.path =~ /^\/login$/
      conn.redirect("/login")
      return
    end

    call_next(conn)
  end
end
