module Inventory
  class Series < Crecto::Model
    schema "inv_series" do
      field :name, String

      has_many :games, Game
    end
  end
end
