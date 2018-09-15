module Inventory
  class Category < Crecto::Model
    schema "inv_categories" do
      field :name, String
      field :rules, String

      belongs_to :game, Game
    end

    def to_h
      {
        "id" => id,
        "name" => name,
        "rules" => rules,
        "game" => game_id ? game.to_h : nil
      }
    end
  end
end
