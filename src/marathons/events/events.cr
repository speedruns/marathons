require "./models/**"

module Events
  extend self

  ###
  # Events
  ###

  def list_events(query : Query = Query.new)
    Repo.all(Event, query)
  end

  def get_event(event_id, query : Query = Query.new)
    Repo.get(Event, event_id, query)
  end

  def new_event()
    Event.new
  end

  def create_event(attrs)
    event = Event.new.cast(attrs)
    Repo.insert(event)
  end

  def update_event(event : Event, changes)
    changeset = event.cast(changes)
    Repo.update(changeset)
  end

  def get_event_for_subdomain(subdomain : String)
    Repo.get_by(Event, subdomain: subdomain)
  end



  ###
  # Submissions
  ###

  def list_submissions(query : Query = Query.new)
    Repo.all(Submission, query)
  end

  def get_submission(submission_id, query : Query = Query.new)
    Repo.get(Submission, submission_id, query)
  end

  def new_submission()
    Submission.new
  end

  def create_submission(attrs)
    submission = Submission.new.cast(attrs)
    Repo.insert(submission)
  end

  def update_submission(submission : Submission, changes)
    changeset = submission.cast(changes)
    Repo.update(changeset)
  end
end
