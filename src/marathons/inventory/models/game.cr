module Inventory
  class Game < Crecto::Model
    schema "inv_games" do
      field :name, String
      field :series_number, Int32

      field :twitch_id, String

      belongs_to :series, Series
      has_many :categories, Category
    end
  end
end
