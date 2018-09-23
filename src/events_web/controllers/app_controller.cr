class EventsWebController
  include Orion::ControllerHelper
  include EventsWebRouter::Helpers

  def redirect_to(location, status : Int32 = 301)
    response.headers.add "Location", location
    response.status_code = 301
  end

  def render(template, locals={} of String => String)
    Template.render(@context, template, locals)
  end
end
