class APIController < EventsWebController
  def render_json(content : String)
    @context.response.headers.add "Content-Type", "application/json"
    @context.response.puts(content)
  end

  def render_json(content : IO)
    @context.response.headers.add "Content-Type", "application/json"
    @context.response << content
  end

  def render_json(content)
    @context.response.headers.add "Content-Type", "application/json"
    @context.response.puts(content.to_json)
  end
end
