class ProfileController < EventsWebController
  def new
    user = Accounts.new_user()
    render("profile/new.html.j2", {
      "user" => user.to_h
    })
  end

  def create
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    if user = Accounts.create_user(params)
      redirect_to(login_path)
    else
      user = Accounts.new_user()
      render("profile/new.html.j2", {
        "user" => user.to_h
      })
    end
  end

  def show
    render("profile/show.html.j2", {
      "user" => @context.current_user.to_h
    })
  end

  def edit
    render("profile/edit.html.j2", {
      "user" => @context.current_user.to_h
    })
  end

  def update
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    if user = Accounts.update_user(@context.current_user, params)
      redirect_to(profile_path)
    else
      render("profile/edit.html.j2", {
        "user" => @context.current_user.to_h
      })
    end
  end
end
