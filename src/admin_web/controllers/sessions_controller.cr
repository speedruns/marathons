module SessionsController
  extend self

  def _new(env)
    user = Accounts.new_user().to_h
    redirect = env.params.query["redirect"]?
    Template.render(env, "sessions/new.html.j2", {
      "user" => user,
      "redirect" => redirect
    })
  end

  def create(env)
    redirect = env.params.query["redirect"]?
    user = Accounts.list_users(Query.where(name: env.params.body["username"]).limit(1)).first?

    unless user && user.admin
      Template.render(env, "sessions/new.html.j2", {
        "user" => Accounts.new_user().to_h,
        "redirect" => redirect
      })
      return
    end

    session = Accounts.create_session(user, env.params.body["password"])
    if session
      env.response.cookies << HTTP::Cookie.new(
        name: "marathons_session_id",
        value: session.instance.key.not_nil!,
        domain: env.request.host,
        http_only: true
      )
      env.redirect(redirect || "/users")
    else
      Template.render(env, "sessions/new.html.j2", {
        "user" => user.to_h,
        "redirect" => redirect
      })
    end
  end

  def delete(env)
    if env.session?
      Accounts.invalidate_session(env.session)
      env.response.headers.add("Cache-Control", "no-cache, no-store, must-revalidate")
      env.response.headers.add("Pragma", "no-cache")
      env.response.headers.add("Expires", "0")
      env.response.cookies << HTTP::Cookie.new(
        name: "marathons_session_id",
        value: "",
        domain: nil,
        expires: Time.epoch(0),
        http_only: true
      )
    end

    env.redirect("/users")
  end
end
