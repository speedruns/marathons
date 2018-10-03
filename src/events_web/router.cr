router EventsWebRouter do
  use HTTP::LogHandler.new(STDOUT)

  ## Static assets
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end

  ## App Routes
  use SessionHandler
  use EventContextHandler

  # Custom app assets
  scope "assets" do
    use CustomAssetHandler.new("public/custom_assets/")
  end

  root controller: StaticController, action: index

  scope do
    resources :submissions, only: [:index, :show]

    use AuthenticationHandler
    resources :submissions, except: [:index, :show] do
      get "/delete", controller: SubmissionsController, action: delete
    end
    post "/submissions/:submission_id", controller: SubmissionsController, action: update
    get "/submit", controller: SubmissionsController, action: new
  end

  ## Profiles
  scope "profile" do
    get   "/new", controller: ProfileController, action: new, helper: "new_profile"
    post  "/create", controller: ProfileController, action: create

    use AuthenticationHandler
    get   "/", controller: ProfileController, action: show, helper: "profile"
    get   "/edit", controller: ProfileController, action: edit, helper: "edit_profile"
    post  "/", controller: ProfileController, action: update
  end

  ## Sessions
  get   "/login", controller: SessionsController, action: new, helper: "login"
  post  "/login", controller: SessionsController, action: create
  get   "/logout", controller: SessionsController, action: delete, helper: "logout"

  ## Errors
  match "404", controller: ErrorsController, action: error_404
end
