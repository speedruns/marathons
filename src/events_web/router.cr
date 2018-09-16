router EventsWebRouter do
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false)
  end

  use EventContextHandler

  match "404", controller: ErrorsController, action: error_404
end
