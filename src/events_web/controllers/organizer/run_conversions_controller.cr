class Organizer::RunConversionsController < EventsWebController
  def index
    runs = Events.list_runs(Query.
      order_by("created_at ASC").
      preload([:runner, :game, :category, :submission])
    )

    pending_submissions = Events.list_submissions(Query.
      order_by("created_at ASC").
      preload([:account, :game, :runs])
    ).reject{ |s| s.runs.size > 0 }

    render("organizer/run_conversions/index.html.j2", {
      "pending_submissions" => pending_submissions.map(&.to_h),
    })
  end

  def show
    submission_id = request.path_params["submission_id"]
    submission = Events.get_submission(submission_id, Query.preload([:account, :game, :category]))
    unless submission
      redirect_to organizer_runs_convert_path
      return
    end

    games = Inventory.list_games()
    categories = Inventory.list_categories(Query.where(game_id: submission.game_id))
    run_changeset = Events.run_from_submission(submission)

    render("organizer/run_conversions/show.html.j2", {
      "submission" => submission.to_h,
      "changeset" => run_changeset.to_h,
      "games" => games.map(&.to_h),
      "categories" => categories.map(&.to_h),
      "run" => run_changeset.instance.to_h
    })
  end

  def create
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    estimate_ms = Time::Span.new(
      params["estimate_hours"].to_i,
      params["estimate_minutes"].to_i,
      params["estimate_seconds"].to_i
    ).total_milliseconds
    pb_ms = Time::Span.new(
      params["pb_hours"].to_i,
      params["pb_minutes"].to_i,
      params["pb_seconds"].to_i
    ).total_milliseconds

    params = params.merge({
      "event_id" => context.event.id,
      "estimate" => estimate_ms.to_i,
      "pb" => pb_ms.to_i
    })

    puts params.inspect
    submission = Events.create_run(params)
    redirect_to(organizer_runs_path)
  end
end
