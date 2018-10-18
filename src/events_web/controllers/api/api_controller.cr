class APIController < EventsWebController
  def render_json(content : String)
    @context.response.puts(content)
  end

  def render_json(content)
    @context.response.puts(content.to_json)
  end
end
