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
end
