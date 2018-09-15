require "./models/**"

module Inventory
  extend self

  ###
  # Series
  ###

  def list_series(query : Query = Query.new)
    Repo.all(Series, query)
  end

  def get_series(series_id, query : Query = Query.new)
    Repo.get(Series, series_id, query)
  end

  def new_series()
    Series.new
  end

  def create_series(attrs)
    series = Series.new.cast(attrs)
    Repo.insert(series)
  end

  def update_series(series : Series, changes)
    changeset = series.cast(changes)
    Repo.update(changeset)
  end


  ###
  # Games
  ###

  def list_games(query : Query = Query.new)
    Repo.all(Game, query)
  end

  def get_game(game_id, query : Query = Query.new)
    Repo.get(Game, game_id, query)
  end

  def new_game()
    Game.new
  end

  def create_game(attrs)
    game = Game.new.cast(attrs)
    Repo.insert(game)
  end

  def update_game(game : Game, changes)
    changeset = game.cast(changes)
    Repo.update(changeset)
  end


  ###
  # Categories
  ###

  def list_categories(query : Query = Query.new)
    Repo.all(Category, query)
  end

  def get_category(category_id, query : Query = Query.new)
    Repo.get(Category, category_id, query)
  end

  def new_category()
    Category.new
  end

  def create_category(attrs)
    category = Category.new.cast(attrs)
    Repo.insert(category)
  end

  def update_category(category : Category, changes)
    changeset = category.cast(changes)
    Repo.update(changeset)
  end
end
