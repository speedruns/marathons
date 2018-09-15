module Inventory
  class Game < Crecto::Model
    schema "inv_games" do
      field :name, String
      field :series_number, Int32

      field :twitch_id, String

      belongs_to :series, Series
      has_many :categories, Category
    end


    def to_h
      {
        "id" => id,
        "name" => name,
        "series_number" => series_number,
        "twitch_id" => twitch_id,
        "series" => series_id ? series.to_h : nil
      }
    end
  end
end
