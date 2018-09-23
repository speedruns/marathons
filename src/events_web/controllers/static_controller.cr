class StaticController < EventsWebController
  def index()
    render("static/home.html.j2")
  end
end
