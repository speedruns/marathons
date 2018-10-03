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
    Repo.all(Series, query.where(id: series_id).limit(1)).first?
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

  def delete_series(series : Series)
    Repo.delete(series)
  end


  ###
  # Games
  ###

  def list_games(query : Query = Query.new)
    Repo.all(Game, query)
  end

  def get_game(game_id, query : Query = Query.new)
    Repo.all(Game, query.where(id: game_id).limit(1)).first?
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

  def delete_game(game : Game)
    Repo.delete(game)
  end


  ###
  # Categories
  ###

  def list_categories(query : Query = Query.new)
    Repo.all(Category, query)
  end

  def get_category(category_id, query : Query = Query.new)
    Repo.all(Category, query.where(id: category_id).limit(1)).first?
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

  def delete_category(category : Category)
    Repo.delete(category)
  end
end
