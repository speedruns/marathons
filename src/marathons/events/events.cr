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
    Repo.all(Event, query.where(id: event_id).limit(1)).first?
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

  def delete_event(event : Event)
    Repo.delete(event)
  end

  def get_event_for_subdomain(subdomain : String)
    Repo.get_by(Event, subdomain: subdomain)
  end

  def accepting_submissions?(event : Event)
    event.state == "accepting_submissions"
  end



  ###
  # Organizers
  ###

  def list_organizers(query : Query = Query.new)
    Repo.all(Organizer, query)
  end

  def list_event_organizers(event : Event, query : Query = Query.new)
    list_organizers(query.where(event_id: event.id))
  end

  def get_organizer(organizer_id, query : Query = Query.new)
    Repo.all(Organizer, query.where(id: organizer_id).limit(1)).first?
  end

  def new_organizer()
    Organizer.new
  end

  def create_organizer(attrs)
    organizer = Organizer.new.cast(attrs)
    Repo.insert(organizer)
  end

  def delete_organizer(organizer : Organizer)
    Repo.delete(organizer)
  end

  def update_organizer(organizer : Organizer, changes)
    changeset = organizer.cast(changes)
    Repo.update(changeset)
  end

  def user_is_organizer?(event : Event, user_id)
    !!Repo.get_by(Organizer, event_id: event.id, user_id: user_id)
  end



  ###
  # Submissions
  ###

  def list_submissions(query : Query = Query.new)
    Repo.all(Submission, query)
  end

  def get_submission(submission_id, query : Query = Query.new)
    Repo.all(Submission, query.where(id: submission_id).limit(1)).first?
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

  def delete_submission(submission_id)
    Repo.delete_all(Submission, Query.where(id: submission_id))
  end

  def submitted_by(account_id, query = Query.new) : Query
    query.where(account_id: account_id)
  end



  ###
  # Schedules
  ###

  def list_schedules(query : Query = Query.new)
    Repo.all(Schedule, query)
  end

  def get_schedule(schedule_id, query : Query = Query.new)
    Repo.all(Schedule, query.where(id: schedule_id).limit(1)).first?
  end

  def new_schedule()
    Schedule.new
  end

  def create_schedule(attrs)
    schedule = Schedule.new.cast(attrs)
    Repo.insert(schedule)
  end

  def update_schedule(schedule : Schedule, changes)
    changeset = schedule.cast(changes)
    Repo.update(changeset)
  end

  def delete_schedule(schedule_id)
    Repo.delete_all(Schedule, Query.where(id: schedule_id))
  end



  ###
  # Runs
  ###

  def list_runs(query : Query = Query.new)
    Repo.all(Run, query)
  end

  def get_run(run_id, query : Query = Query.new)
    Repo.all(Run, query.where(id: run_id).limit(1)).first?
  end

  def new_run()
    Run.new
  end

  def create_run(attrs)
    run = Run.new.cast(attrs)
    Repo.insert(run)
  end

  def update_run(run : Run, changes)
    changeset = run.cast(changes)
    Repo.update(changeset)
  end

  def delete_run(run_id)
    Repo.delete_all(Run, Query.where(id: run_id))
  end

  def run_from_submission(submission : Submission)
    run_params = submission.to_h
    run_params["runner_id"] = submission.account_id

    Run.new.cast(run_params)
  end
end
