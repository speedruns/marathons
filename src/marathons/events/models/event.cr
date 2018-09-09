module Events
  class Event < Crecto::Model
    schema "ev_events" do
      field :name, String
      field :start_date, String
      field :end_date, String

      belongs_to :organization, Accounts::Organization
    end
  end
end
