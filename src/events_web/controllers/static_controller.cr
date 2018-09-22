class StaticController < EventsWebController
  def index()
    Template.render(@context, "static/home.html.j2")
  end
end
