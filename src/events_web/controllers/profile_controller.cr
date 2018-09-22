class ProfileController < EventsWebController
  def show
    Template.render(@context, "profile/show.html.j2", {
      "user" => @context.current_user.to_h
    })
  end

  def edit
    Template.render(@context, "profile/edit.html.j2", {
      "user" => @context.current_user.to_h
    })
  end

  def update
    params = HTTP::Params.parse(request.body.not_nil!.gets_to_end).to_h
    if user = Accounts.update_user(@context.current_user, params)
      redirect_to(profile_path)
    else
      Template.render(@context, "profile/edit.html.j2", {
        "user" => @context.current_user.to_h
      })
    end
  end
end
