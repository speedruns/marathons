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

  get   "/submissions", controller: SubmissionsController, action: index
  # get   "/submissions/:submission_id", controller: SubmissionsController, action: show
  get   "/submissions/new", controller: SubmissionsController, action: _new
  post  "/submissions", controller: SubmissionsController, action: create
  get   "/submissions/:submission_id/edit", controller: SubmissionsController, action: edit
  post  "/submissions/:submission_id", controller: SubmissionsController, action: update


  ## Errors
  match "404", controller: ErrorsController, action: error_404
end
