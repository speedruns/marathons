module OrganizersController
  extend self

  def index(env)
    organizers = Events.list_organizers(Query.preload([:event, :user]))
    organizers = organizers.map(&.to_h)
    Template.render(env, "events/organizers/index.html.j2", {
      "organizers" => organizers
    })
  end

  def show(env)
    organizer_id = env.params.url["organizer_id"]
    if organizer = Events.get_organizer(organizer_id, Query.preload([:event, :user]))
      Template.render(env, "events/organizers/show.html.j2", {
        "organizer" => organizer.to_h
      })
    else
      env.redirect("/organizers")
    end
  end

  def _new(env)
    organizer = Events.new_organizer()
    events = Events.list_events(Query.order_by("name ASC")).map(&.to_h)
    users = Accounts.list_users(Query.order_by("name ASC")).map(&.to_h)
    Template.render(env, "events/organizers/new.html.j2", {
      "organizer" => organizer.to_h,
      "events" => events,
      "users" => users
    })
  end

  def create(env)
    params = env.params.body
    Events.create_organizer(params)
    env.redirect("/organizers")
  end

  def edit(env)
    organizer_id = env.params.url["organizer_id"]
    if organizer = Events.get_organizer(organizer_id, Query.preload([:event, :user]))
      events = Events.list_events(Query.order_by("name ASC")).map(&.to_h)
      users = Accounts.list_users(Query.order_by("name ASC")).map(&.to_h)
      Template.render(env, "events/organizers/edit.html.j2", {
        "organizer" => organizer.to_h,
        "events" => events,
        "users" => users
      })
    else
      env.redirect("/organizers")
    end
  end

  def update(env)
    organizer_id = env.params.url["organizer_id"]
    if organizer = Events.get_organizer(organizer_id)
      Events.update_organizer(organizer, env.params.body)
    end

    env.redirect("/organizers")
  end

  def destroy(env)
    organizer_id = env.params.url["organizer_id"]
    if organizer = Events.get_organizer(organizer_id)
      Events.delete_organizer(organizer)
    end

    env.redirect("/organizers")
  end
end
