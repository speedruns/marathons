require "../../util/time.cr"

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

      belongs_to :game, Inventory::Game
      belongs_to :category, Inventory::Category

      # There's a non-negligible chance that submitted categories won't
      # already exist in the system. In this case, users can submit a raw
      # category and/or game name in their place.
      field :game_name, String
      field :category_name, String

      has_many :runs, Run, dependent: :nullify
    end

    validate_inclusion :status, in: ["draft", "pending", "acccepted", "rejected"]

    def to_h
      {
        "id" => id,
        "description" => description,
        "video_link" => video_link,
        "estimate" => estimate,
        "pb" => pb,
        "submitted_at" => submitted_at,
        "status" => status,
        "event_id" => event_id,
        "event" => event?.try(&.to_h),
        "account_id" => account_id,
        "account" => account?.try(&.to_h),
        "category_id" => category_id,
        "category" => category?.try(&.to_h),
        "category_name" => category_name,
        "game_id" => game_id,
        "game" => game?.try(&.to_h),
        "game_name" => game_name
      }
    end
  end
end
