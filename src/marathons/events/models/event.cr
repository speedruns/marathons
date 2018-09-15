module Events
  class Event < Crecto::Model
    schema "ev_events" do
      field :name, String
      field :start_date, String
      field :end_date, String

      belongs_to :organization, Accounts::Organization
    end

    validate_required :name


    def to_h
      {
        "id" => id,
        "name" => name,
        "start_date" => start_date,
        "end_date" => end_date,
        "organization" => organization_id ? organization.to_h : nil,
      }
    end
  end
end
