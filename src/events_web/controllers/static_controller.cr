class StaticController < EventsWebController
  def index
    accepted_runs = Events.list_runs(Query
      .where(status: "accepted")
      .preload([:game, :category, :runner])
      .order_by("game_id ASC")
      .order_by("category_id ASC")
    )

    profile_runs, runs =
      if user = @context.current_user?
        accepted_runs.partition do |run|
          run.runner_id == user.id
        end
      else
        {[] of Events::Run, accepted_runs}
      end

    case @context.event.state
    when "decided"
      render("static/home_decided.html.j2", {
        "profile_runs" => profile_runs.map(&.to_h),
        "runs" => runs.map(&.to_h)
      })
    when "scheduled"
      render("static/home_scheduled.html.j2")
    else
      render("static/home.html.j2")
    end
  end
end
