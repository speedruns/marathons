class StaticController < AppController
  def index()
    Template.render(@context, "static/home.html.j2")
  end
end
