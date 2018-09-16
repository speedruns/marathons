module SeriesController
  extend self

  def index(env)
    series = Inventory.list_series()
    series = series.map(&.to_h)
    Template.render(env, "inventory/series/index.html.j2", series_list: series)
  end

  def show(env)
    series_id = env.params.url["series_id"]
    if series = Inventory.get_series(series_id)
      Template.render(env, "inventory/series/show.html.j2", series: series.to_h)
    else
      env.redirect("/series")
    end
  end

  def _new(env)
    series = Inventory.new_series()
    Template.render(env, "inventory/series/new.html.j2", series: series.to_h)
  end

  def create(env)
    params = env.params.body
    Inventory.create_series(params)
    env.redirect("/series")
  end

  def edit(env)
    series_id = env.params.url["series_id"]
    if series = Inventory.get_series(series_id)
      Template.render(env, "inventory/series/edit.html.j2", series: series.to_h)
    else
      env.redirect("/series")
    end
  end

  def update(env)
    series_id = env.params.url["series_id"]
    if series = Inventory.get_series(series_id)
      Inventory.update_series(series, env.params.body)
    end

    env.redirect("/series")
  end
end
