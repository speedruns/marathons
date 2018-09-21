class SubmissionsController < AppController
  def index
    submissions = Events.list_submissions(Query.preload([:account, :event, :category, :game])).map(&.to_h)
    Template.render(@context, "submissions/index.html.j2", submissions: submissions)
  end

  def _new
    submission = Events.new_submission()
    games = Inventory.list_games().map(&.to_h)
    categories = Inventory.list_categories().map(&.to_h)
    Template.render(@context, "submissions/new.html.j2", submission: submission.to_h, games: games, categories: categories)
  end

  def create
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    params = params.merge({
      "event_id" => context.event.id.to_s,
      "account_id" => "1"
    })

    submission = Events.create_submission(params)
    redirect_to("/submissions")
  end

  def edit
    submission_id = request.path_params["submission_id"]
    if submission = Events.get_submission(submission_id)
      games = Inventory.list_games().map(&.to_h)
      categories = Inventory.list_categories().map(&.to_h)
      Template.render(@context, "submissions/edit.html.j2", submission: submission.to_h, games: games, categories: categories)
    else
      redirect_to("/submissions")
    end
  end

  def update
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    params = params.merge({
      "event_id" => context.event.id.to_s,
      "account_id" => "1"
    })

    submission_id = request.path_params["submission_id"]
    if submission = Events.get_submission(submission_id)
      Events.update_submission(submission, params)
    end

    redirect_to("/submissions")
  end
end
