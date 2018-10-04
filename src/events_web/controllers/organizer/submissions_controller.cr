class Organizer::SubmissionsController < EventsWebController
  def index
    submissions = Events.list_submissions(Query.
      order_by("game_id ASC").
      order_by("account_id ASC").
      order_by("category_name ASC").
      preload([:account, :event, :game])
    )

    render("organizer/submissions/index.html.j2", {
      "submissions" => submissions.map(&.to_h),
    })
  end
end
