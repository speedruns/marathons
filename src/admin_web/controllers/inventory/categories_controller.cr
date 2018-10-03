module CategoriesController
  extend self

  def index(env)
    categories = Inventory.list_categories(Query.preload(:game))
    categories = categories.map(&.to_h)
    Template.render(env, "inventory/categories/index.html.j2", {
      "categories" => categories
    })
  end

  def show(env)
    category_id = env.params.url["category_id"]
    if category = Inventory.get_category(category_id, Query.preload(:game))
      Template.render(env, "inventory/categories/show.html.j2", {
        "category" => category.to_h
      })
    else
      env.redirect("/categories")
    end
  end

  def _new(env)
    category = Inventory.new_category()
    games = Inventory.list_games().map{ |g| {name: g.name, id: g.id} }
    Template.render(env, "inventory/categories/new.html.j2", {
      "category" => category.to_h,
      "games" => games
    })
  end

  def create(env)
    params = env.params.body
    Inventory.create_category(params)
    env.redirect("/categories")
  end

  def edit(env)
    category_id = env.params.url["category_id"]
    if category = Inventory.get_category(category_id, Query.preload(:game))
      games = Inventory.list_games().map{ |g| {name: g.name, id: g.id} }
      Template.render(env, "inventory/categories/edit.html.j2", {
        "category" => category.to_h,
        "games" => games
      })
    else
      env.redirect("/categories")
    end
  end

  def update(env)
    category_id = env.params.url["category_id"]
    if category = Inventory.get_category(category_id)
      Inventory.update_category(category, env.params.body)
    end

    env.redirect("/categories")
  end

  def destroy(env)
    category_id = env.params.url["category_id"]
    if category = Inventory.get_category(category_id)
      Inventory.delete_category(category)
    end

    env.redirect("/categories")
  end
end
