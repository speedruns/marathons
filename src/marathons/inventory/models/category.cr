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
        "game_id" => game_id,
        "game" => game?.try(&.to_h)
      }
    end
  end
end
