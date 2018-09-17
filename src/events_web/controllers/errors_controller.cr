class ErrorsController
  include Orion::ControllerHelper

  def error_404()
    Template.render(@context, "errors/404.html.j2", resource: request.resource)
  end
end