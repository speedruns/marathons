router EventsWebRouter do
  use HTTP::LogHandler.new(STDOUT)
  use EventContextHandler

  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false)
  end





  match "404", controller: ErrorsController, action: error_404
end
