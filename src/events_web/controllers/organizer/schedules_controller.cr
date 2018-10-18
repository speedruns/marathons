class Organizer::SchedulesController < EventsWebController
  def index
    schedules = Events.list_schedules(Query.preload([:schedulings, :runs])).map(&.to_h)
    render("organizer/schedules/index.html.j2", {
      "schedules" => schedules
    })
  end

  def new
    schedule = Events.new_schedule()
    runs = Events.list_runs(Query.preload([:game, :category, :runner]))
    render("organizer/schedules/new.html.j2", {
      "schedule" => schedule.to_h,
      "runs" => runs.map(&.to_h)
    })
  end

  def show
  end

  def create
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    params = params.merge({
      "event_id" => context.event.id.to_s
    })

    schedule = Events.create_schedule(params)
    redirect_to(organizer_schedules_path)
  end

  def edit
    schedule_id = request.path_params["schedule_id"]
    if schedule = Events.get_schedule(schedule_id)
      runs = Events.list_runs(Query.preload([:game, :category, :runner]))
      render("organizer/schedules/edit.html.j2", {
        "schedule" => schedule.to_h,
        "runs" => runs.map(&.to_h)
      })
    else
      redirect_to(organizer_schedules_path)
    end
  end

  def update
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h

    schedule_id = request.path_params["schedule_id"]
    if schedule = Events.get_schedule(schedule_id)
      Events.update_schedule(schedule, params)
    end

    redirect_to(organizer_schedules_path)
  end

  def delete
    schedule_id = request.path_params["schedule_id"]
    Events.delete_schedule(schedule_id)

    redirect_to(organizer_schedules_path)
  end
end
