module GamesController
  extend self

  def index(env)
    games = Inventory.list_games(Query.preload(:series))
    games = games.map(&.to_h)
    Template.render("inventory/games/index.html.j2", games: games)
  end

  def show(env)
    game_id = env.params.url["game_id"]
    if game = Inventory.get_game(game_id, Query.preload(:series))
      Template.render("inventory/games/show.html.j2", game: game.to_h)
    else
      env.redirect("/games")
    end
  end

  def _new(env)
    game = Inventory.new_game()
    series = Inventory.list_series().map{ |s| {name: s.name, id: s.id} }
    Template.render("inventory/games/new.html.j2", game: game.to_h, series_list: series)
  end

  def create(env)
    params = env.params.body
    Inventory.create_game(params)
    env.redirect("/games")
  end

  def edit(env)
    game_id = env.params.url["game_id"]
    if game = Inventory.get_game(game_id, Query.preload(:series))
      series = Inventory.list_series().map{ |s| {name: s.name, id: s.id} }
      Template.render("inventory/games/edit.html.j2", game: game.to_h, series_list: series)
    else
      env.redirect("/games")
    end
  end

  def update(env)
    game_id = env.params.url["game_id"]
    if game = Inventory.get_game(game_id)
      Inventory.update_game(game, env.params.body)
    end

    env.redirect("/games")
  end
end
