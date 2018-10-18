class API::Organizer::RunsController < APIController
  def index
    runs = Events.list_runs(Query.
      order_by("created_at ASC").
      preload([:runner, :game, :category])
    )

    render_json runs.map(&.to_h)
  end
end
