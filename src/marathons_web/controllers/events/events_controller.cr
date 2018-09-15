module EventsController
  extend self

  def index(env)
    events = Events.list_events()
    events = events.map(&.to_h)
    Template.render("events/events/index.html.j2", events: events)
  end

  def show(env)
    event_id = env.params.url["event_id"]
    if event = Events.get_event(event_id)
      Template.render("events/events/show.html.j2", event: event.to_h)
    else
      env.redirect("/events")
    end
  end

  def _new(env)
    event = Events.new_event()
    Template.render("events/events/new.html.j2", event: event.to_h)
  end

  def create(env)
    params = env.params.body
    Events.create_event(params)
    env.redirect("/events")
  end

  def edit(env)
    event_id = env.params.url["event_id"]
    if event = Events.get_event(event_id)
      Template.render("events/events/edit.html.j2", event: event.to_h)
    else
      env.redirect("/events")
    end
  end

  def update(env)
    event_id = env.params.url["event_id"]
    if event = Events.get_event(event_id)
      Events.update_event(event, env.params.body)
    end

    env.redirect("/events")
  end
end
