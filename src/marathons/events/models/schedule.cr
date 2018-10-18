module Events
  class Schedule < Crecto::Model
    schema "ev_schedules" do
      belongs_to :event, Event

      field :title, String
      field :start_time, Time
      field :end_time, Time

      # To allow for schedule drafting and backups, runs have a many-to-many
      # relationship with schedules.
      has_many :schedulings, Scheduling
      has_many :runs, Run, through: :schedulings
    end


    def to_h
      {
        "id" => id,
        "event_id" => event_id,
        "event" => event? ? event.to_h : nil,
        "title" => title,
        "start_time" => start_time,
        "end_time" => end_time
      }
    end
  end
end
