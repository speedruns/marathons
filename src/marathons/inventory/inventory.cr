require "./models/**"

module Inventory
  extend self

  def create_series(attrs)
    series = Series.new.cast(attrs)
  end

  def create_game(attrs)
    game = Game.new.cast(attrs)
  end

  def create_category(attrs)
    category = Category.new.cast(attrs)
  end
end
