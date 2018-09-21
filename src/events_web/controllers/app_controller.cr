class AppController
  include Orion::ControllerHelper

  def redirect_to(location, status : Int32 = 301)
    response.headers.add "Location", location
    response.status_code = 301
  end
end
