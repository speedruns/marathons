module Events
  class Organizer < Crecto::Model
    schema "ev_organizers" do
      belongs_to :event, Event
      belongs_to :user, Accounts::User
    end


    def to_h
      {
        "id" => id,
        "event_id" => event_id,
        "event" => event? ? event.to_h : nil,
        "user_id" => user_id,
        "user" => user? ? user.to_h : nil,
      }
    end
  end
end
