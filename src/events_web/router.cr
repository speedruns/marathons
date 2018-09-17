router EventsWebRouter do
  use HTTP::LogHandler.new(STDOUT)


  # Static assets
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false)
  end


  # App Routes
  use EventContextHandler

  root controller: StaticController, action: index


  # Errors
  match "404", controller: ErrorsController, action: error_404
end
