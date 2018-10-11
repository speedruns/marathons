class EventsWebController
  include Orion::ControllerHelper
  include EventsWebRouter::Helpers

  def redirect_to(location, status : Int32 = 302)
    response.headers.add "Location", location
    response.status_code = status
  end

  def render(template, locals={} of String => String)
    Template.render(@context, template, locals)
  end
end
