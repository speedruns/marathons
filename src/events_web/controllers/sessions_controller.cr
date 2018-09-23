class SessionsController < EventsWebController
  def new
    user = Accounts.new_user().to_h
    redirect = request.query_params["redirect"]?
    Template.render(@context, "sessions/new.html.j2", {
      "user" => user,
      "redirect" => redirect
    })
  end

  def create
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    redirect = request.query_params["redirect"]?
    user = Accounts.list_users(Query.where(name: params["username"]).limit(1)).first?

    unless user
      Template.render(@context, "sessions/new.html.j2", {
        "user" => Accounts.new_user().to_h,
        "redirect" => redirect
      })
      return
    end

    session = Accounts.create_session(user, params["password"])
    if session
      response.cookies << HTTP::Cookie.new(
        name: "marathons_session_id",
        value: session.instance.key.not_nil!,
        domain: request.host,
        http_only: true
      )
      redirect_to(redirect || root_path)
    else
      Template.render(@context, "sessions/new.html.j2", {
        "user" => user.to_h,
        "redirect" => redirect
      })
    end
  end

  def delete
    if @context.session
      Accounts.invalidate_session(@context.session)
      @context.response.headers.add("Cache-Control", "no-cache, no-store, must-revalidate")
      @context.response.headers.add("Pragma", "no-cache")
      @context.response.headers.add("Expires", "0")
      @context.response.cookies << HTTP::Cookie.new(
        name: "marathons_session_id",
        value: "",
        domain: nil,
        expires: Time.epoch(0),
        http_only: true
      )
    end

    redirect_to root_path
  end
end
