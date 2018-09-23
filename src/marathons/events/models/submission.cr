module Events
  class Submission < Crecto::Model
    schema "ev_submissions" do
      belongs_to :event, Event
      belongs_to :account, Accounts::User, foreign_key: :account_id

      field :description, String
      field :video_link, String
      # TODO: Convert these to proper time representations
      field :estimate, String
      field :pb, String

      field :submitted_at, Time
      field :status, String, default: "pending"

      belongs_to :category, Inventory::Category
      belongs_to :game, Inventory::Game
    end

    validate_inclusion :status, in: ["draft", "pending", "acccepted", "rejected"]

    def to_h
      {
        "id" => id,
        "description" => description,
        "video_link" => video_link,
        "estimate" => format_time(estimate),
        "pb" => format_time(pb),
        "submitted_at" => submitted_at,
        "status" => status,
        "event_id" => event_id,
        "event" => event?.try(&.to_h),
        "account_id" => account_id,
        "account" => account?.try(&.to_h),
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
