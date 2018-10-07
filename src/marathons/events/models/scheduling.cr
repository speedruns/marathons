module Events
  class Scheduling < Crecto::Model
    schema "ev_schedulings" do
      belongs_to :schedule, Schedule
      belongs_to :run, Run

      field :start_time, Time
      field :end_time, Time
      field :completed, Bool, default: false
    end


    def to_h
      {
        "id" => id,
        "schedule_id" => schedule_id,
        "schedule" => schedule? ? schedule.to_h : nil,
        "run_id" => run_id,
        "run" => run? ? run.to_h : nil,
        "start_time" => start_time,
        "end_time" => end_time,
        "completed" => completed
      }
    end
  end
end
