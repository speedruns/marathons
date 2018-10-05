class Organizer::SubmissionsController < EventsWebController
  def index
    submissions = Events.list_submissions(Query.
      order_by("created_at ASC").
      preload([:account, :event, :game])
    )

    render("organizer/submissions/index.html.j2", {
      "submissions" => submissions.map(&.to_h),
    })
  end
end
