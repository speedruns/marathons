module Events
  class Scheduling < Crecto::Model
    schema "ev_schedulings" do
      belongs_to :schedule, Schedule
      # Instead of a single polymorphic association, separate associations
      # are used for each kind of schedule entry. For any given Scheduling
      # record, only one of these associations may be set.
      belongs_to :run, Run
      belongs_to :race, Race

      field :start_time, Time
      field :end_time, Time
      field :completed, Bool, default: false
    end

    validate "only one associated entry kind", ->(scheduling : Scheduling) do
      [scheduling.run_id, scheduling.race_id].compact.size <= 1
    end

    def kind
      case
      when run_id
        :run
      when race_id
        :race
      end
    end


    def to_h
      {
        "id" => id,
        "schedule_id" => schedule_id,
        "schedule" => schedule? ? schedule.to_h : nil,
        "run_id" => run_id,
        "run" => run? ? run.to_h : nil,
        "race_id" => race_id,
        "race" => race? ? race.to_h : nil,
        "start_time" => start_time,
        "end_time" => end_time,
        "completed" => completed
      }
    end
  end
end
