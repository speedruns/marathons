router EventsWebRouter do
  use HTTP::LogHandler.new(STDOUT)

  ## Static assets
  scope "css" do
    use HTTP::StaticFileHandler.new("public/", fallthrough: false, directory_listing: false)
  end
  scope "js" do
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


  ## Organizers
  scope "organizer", helper_prefix: "organizer" do
    use AuthenticationHandler
    use AuthorizationHandler.new(required_level: :organizer)

    # Submissions
    get "/submissions", controller: Organizer::SubmissionsController, action: index, helper: "submissions"

    resources :schedules, controller: Organizer::SchedulesController

    # Runs
    get   "/runs/convert", controller: Organizer::RunConversionsController, action: index, helper: "runs_convert"
    post  "/runs/convert", controller: Organizer::RunConversionsController, action: create
    get   "/runs/convert/:submission_id", controller: Organizer::RunConversionsController, action: show
    resources :runs, controller: Organizer::RunsController do
      get "/delete", controller: Organizer::RunsController, action: delete
    end
    post "/runs/:run_id", controller: Organizer::RunsController, action: update
  end


  ## Sessions
  get   "/login", controller: SessionsController, action: new, helper: "login"
  post  "/login", controller: SessionsController, action: create
  get   "/logout", controller: SessionsController, action: delete, helper: "logout"

  ## Errors
  match "404", controller: ErrorsController, action: error_404



  ## API
  scope "api", helper_prefix: "api" do
    # public, unauthenticated API
    get "/horaro/schedule/:schedule_id", controller: API::HoraroController, action: show

    use APIHandler
    use AuthenticationHandler

    scope "organizer", helper_prefix: "organizer" do
      use AuthorizationHandler.new(required_level: :organizer)

      get "/runs", controller: API::Organizer::RunsController, action: index, helper: "runs"
    end
  end
end
