class StaticController
  include Orion::ControllerHelper

  def index()
    CustomTemplate.render(@context, "static/home.html.j2")
  end
end
