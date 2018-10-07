class Organizer::SchedulesController < EventsWebController
  def index
    schedules = Events.list_schedules(Query.preload([:schedulings, :runs])).map(&.to_h)
    render("organizer/schedules/index.html.j2", {
      "schedules" => schedules
    })
  end

  def new
    require_accepting_submissions!
    submission = Events.new_submission()
    games = Inventory.list_games().map(&.to_h)
    categories = Inventory.list_categories().map(&.to_h)
    render("organizer/schedules/new.html.j2", {
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
      "event_id" => context.event.id.to_s,
      "account_id" => context.current_user.id.to_s
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
