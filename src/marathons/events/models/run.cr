require "../../util/time.cr"

module Events
  class Run < Crecto::Model
    schema "ev_runs" do
      belongs_to :event, Event
      belongs_to :runner, Accounts::User, foreign_key: :runner_id
      belongs_to :submission, Submission

      field :description, String
      field :video_link, String
      # Times are all stored in milliseconds
      field :estimate, Int64
      field :pb, Int64
      field :time, Int64


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

    validate_required :event_id
    validate_required :runner_id
    validate_required :game_id
    validate_required :category_id
    validate_required :estimate


    def to_h
      {
        "id" => id,
        "description" => description,
        "video_link" => video_link,
        "estimate" => estimate,
        "pb" => pb,
        "time" => time,
        "estimate_formatted" => Util::TimeParse.format_time(estimate),
        "pb_formatted" => Util::TimeParse.format_time(pb),
        "time_formatted" => Util::TimeParse.format_time(time),
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
  end
end
