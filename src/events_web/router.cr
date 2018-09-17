router EventsWebRouter do
  use HTTP::LogHandler.new(STDOUT)


  ## Static assets
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end


  ## App Routes
  use EventContextHandler

  # Custom app assets
  scope "assets" do
    use CustomAssetHandler.new("public/custom_assets/")
  end

  root controller: StaticController, action: index


  ## Errors
  match "404", controller: ErrorsController, action: error_404
end
