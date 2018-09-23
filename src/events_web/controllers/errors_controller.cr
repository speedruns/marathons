class ErrorsController < EventsWebController
  def error_404()
    render("errors/404.html.j2", {
      "resource" => request.resource
    })
  end
end
