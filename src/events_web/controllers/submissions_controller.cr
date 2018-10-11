class SubmissionsController < EventsWebController
  def index
    submissions = Events.list_submissions(Query.
      order_by("game_id ASC").
      order_by("account_id ASC").
      order_by("category_name ASC").
      preload([:account, :event, :game])
    )

    current_user_id = @context.current_user?.try(&.id)
    profile_submissions, all_submissions = submissions.partition do |s|
      current_user_id.try(&.==(s.account_id))
    end

    render("submissions/index.html.j2", {
      "all_submissions" => all_submissions.map(&.to_h),
      "profile_submissions" => profile_submissions.map(&.to_h)
    })
  end

  def new
    require_accepting_submissions!
    submission = Events.new_submission()
    games = Inventory.list_games().map(&.to_h)
    categories = Inventory.list_categories().map(&.to_h)
    render("submissions/new.html.j2", {
      "submission" => submission.to_h,
      "games" => games,
      "categories" => categories
    })
  end

  def show
  end

  def create
    require_accepting_submissions!
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    params = params.merge({
      "event_id" => context.event.id,
      "account_id" => context.current_user.id
    })

    submission = Events.create_submission(params)
    redirect_to(submissions_path)
  end

  def edit
    submission_id = request.path_params["submission_id"]
    if submission = Events.get_submission(submission_id, Events.submitted_by(@context.current_user.id))
      games = Inventory.list_games().map(&.to_h)
      categories = Inventory.list_categories().map(&.to_h)
      render("submissions/edit.html.j2", {
        "submission" => submission.to_h,
        "games" => games,
        "categories" => categories
      })
    else
      redirect_to(submissions_path)
    end
  end

  def update
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h

    submission_id = request.path_params["submission_id"]
    if submission = Events.get_submission(submission_id)
      Events.update_submission(submission, params)
    end

    redirect_to(submissions_path)
  end

  def delete
    submission_id = request.path_params["submission_id"]
    submission = Events.get_submission(submission_id, Events.submitted_by(@context.current_user.id))
    if submission
      Events.delete_submission(submission_id)
    end

    redirect_to(submissions_path)
  end


  macro require_accepting_submissions!
    unless Events.accepting_submissions?(@context.event)
      # Usea 302 to avoid potential caching issues (301 is a _permanent_
      # redirect and browsers will cache that indefinitely. 302 is _temporary_,
      # so at worst the caching problem will only last a short while).
      redirect_to(root_path, status: 302)
    end
  end
end
