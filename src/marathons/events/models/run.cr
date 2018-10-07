module Events
  class Run < Crecto::Model
    schema "ev_runs" do
      belongs_to :event, Event
      belongs_to :runner, Accounts::User, foreign_key: :runner_id
      belongs_to :submission, Submission

      field :video_link, String
      # TODO: Convert these to proper time representations
      field :estimate, String
      field :pb, String

      field :time, String

      # To allow for schedule drafting and backups, runs have a many-to-many
      # relationship with schedules.
      has_many :schedulings, Scheduling
      has_many :schedules, Schedule, through: :schedulings

      # Unlike Submissions, Runs are expected to be tied to an existing
      # game and category. Since this is done by organizers/a controlled group
      # of people, this is an okay expectation.
      belongs_to :game, Inventory::Game
      belongs_to :category, Inventory::Category
    end


    def to_h
      {
        "id" => id,
        "video_link" => video_link,
        "estimate" => format_time(estimate),
        "pb" => format_time(pb),
        "time" => format_time(time),
        "event_id" => event_id,
        "event" => event?.try(&.to_h),
        "runner_id" => runner_id,
        "runner" => runner?.try(&.to_h),
        "category_id" => category_id,
        "category" => category?.try(&.to_h),
        "game_id" => game_id,
        "game" => game?.try(&.to_h)
      }
    end


    private KNOWN_TIME_FORMATS = [
      "%H:%M:%S.%3N",
      "%H:%M:%S",
      "%H:%M",
      "%H.%M"
    ]

    private def to_milliseconds(time_string : String)
      KNOWN_TIME_FORMATS.each do |format|
        time = Time.parse!(time_string, format)

        break time.hour * 3_600_000 +
              time.minute * 60_000 +
              time.second * 1000 +
              time.millisecond
      rescue
        nil
      end
    end

    private def format_time(time : Nil); ""; end
    private def format_time(time : Time::Span)
      "#{time.hours}:#{time.minutes}:#{time.seconds}.#{time.milliseconds}"
    end
    private def format_time(time : String)
      if ms = to_milliseconds(time)
        format_time(Time::Span.new(nanoseconds: ms * 1000))
      else
        time
      end
    end
  end
end
