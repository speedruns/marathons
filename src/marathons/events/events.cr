require "./models/**"

module Events
  extend self

  def create_event(**attrs)
    event = Event.new.cast(attrs)
  end

  def create_submission(**attrs)
    submission = Submission.new.cast(attrs)
  end

  def create_submission_option(**attrs)
    option = Submission::Option.new.cast(attrs)
  end

  def create_submission_run(**attrs)
    run = Submission::Run.new.cast(attrs)
  end
end
