require "../../util/time.cr"

module Events
  class Race < Crecto::Model
    schema "ev_races" do
      belongs_to :event, Event
      belongs_to :game, Inventory::Game
      belongs_to :category, Inventory::Category

      field :description, String
      field :video_link, String
      field :estimate, Int64

      has_many :race_runs, RaceRun
      has_many :runs, Run, through: :race_runs

      has_many :schedulings, Scheduling
      has_many :schedules, Schedule, through: :schedulings
    end

    validate_required :event_id
    validate_required :game_id
    validate_required :category_id
    validate_required :estimate

    def to_h
      {
        "id" => id,
        "description" => description,
        "video_link" => video_link,
        "estimate" => estimate,
        "estimate_formatted" => Util::TimeParse.format_time(estimate),
        "event_id" => event_id,
        "event" => event?.try(&.to_h),
        "category_id" => category_id,
        "category" => category?.try(&.to_h),
        "game_id" => game_id,
        "game" => game?.try(&.to_h)
      }
    end
  end
end
