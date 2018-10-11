class Organizer::RunsController < EventsWebController
  def index
    runs = Events.list_runs(Query.
      order_by("created_at ASC").
      preload([:runner, :game, :category])
    )

    render("organizer/runs/index.html.j2", {
      "runs" => runs.map(&.to_h),
    })
  end

  def new
    run = Events.new_run()
    games = Inventory.list_games().map(&.to_h)
    categories = Inventory.list_categories().map(&.to_h)
    render("organizer/runs/new.html.j2", {
      "run" => run.to_h,
      "games" => games,
      "categories" => categories
    })
  end

  def show
  end

  def create
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    params = params.merge({
      "event_id" => context.event.id.to_s,
      "estimate" => Util::TimeParse.time_parts_to_milliseconds(params["estimate_hours"].to_i, params["estimate_minutes"].to_i, params["estimate_seconds"].to_i),
      "pb" => Util::TimeParse.time_parts_to_milliseconds(params["pb_hours"].to_i, params["pb_minutes"].to_i, params["pb_seconds"].to_i)
    })

    run = Events.create_run(params)
    redirect_to(organizer_runs_path)
  end

  def edit
    run_id = request.path_params["run_id"]
    if run = Events.get_run(run_id)
      games = Inventory.list_games().map(&.to_h)
      categories = Inventory.list_categories().map(&.to_h)
      render("organizer/runs/edit.html.j2", {
        "run" => run.to_h,
        "games" => games,
        "categories" => categories
      })
    else
      redirect_to(organizer_runs_path)
    end
  end

  def update
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    params = params.merge({
      "event_id" => context.event.id.to_s,
      "estimate" => Util::TimeParse.time_parts_to_milliseconds(params["estimate_hours"].to_i, params["estimate_minutes"].to_i, params["estimate_seconds"].to_i),
      "pb" => Util::TimeParse.time_parts_to_milliseconds(params["pb_hours"].to_i, params["pb_minutes"].to_i, params["pb_seconds"].to_i)
    })

    run_id = request.path_params["run_id"]
    if run = Events.get_run(run_id)
      Events.update_run(run, params)
    end

    redirect_to(organizer_runs_path)
  end

  def delete
    run_id = request.path_params["run_id"]
    run = Events.get_run(run_id)
    if run
      Events.delete_run(run_id)
    end

    redirect_to(organizer_runs_path)
  end
end
