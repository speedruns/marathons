module Inventory
  class Category < Crecto::Model
    schema "inv_categories" do
      field :name, String
      field :rules, String

      belongs_to :game, Game
    end
  end
end
