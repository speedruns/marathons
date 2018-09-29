module Events
  class Event < Crecto::Model
    schema "ev_events" do
      field :name, String
      field :start_date, String
      field :end_date, String
      field :subdomain, String

      field :site_title, String
      field :twitter, String
      field :twitch, String
      field :discord, String

      field :state, String, default: "draft"

      belongs_to :organization, Accounts::Organization
    end

    validate_required :name


    def to_h
      {
        "id" => id,
        "name" => name,
        "start_date" => start_date,
        "end_date" => end_date,
        "site_title" => site_title,
        "twitter" => twitter,
        "twitch" => twitch,
        "discord" => discord,
        "state" => state,
        "subdomain" => subdomain,
        "organization_id" => organization_id,
        "organization" => organization?.try(&.to_h)
      }
    end
  end
end
