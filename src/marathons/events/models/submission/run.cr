module Events
  class Submission::Run < Crecto::Model
    schema "ev_sub_runs" do
      belongs_to :submission, Submission

      field :description, String
      field :video_link, String
      field :estimate_ms, Int32
      field :pb_ms, Int32

      belongs_to :category, Inventory::Category
      belongs_to :game, Inventory::Game
    end
  end
end
