require "http"

# A simple middleware for ensuring that all API requests have the
# `application/json` content type. Will probably do more in the future.
class APIHandler
  include HTTP::Handler

  def call(conn : HTTP::Server::Context)
    conn.response.headers.add "Content-Type", "application/json"

    call_next(conn)
  end
end
