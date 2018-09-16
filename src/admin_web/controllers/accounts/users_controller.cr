module UsersController
  extend self

  def index(env)
    users = Accounts.list_users()
    users = users.map(&.to_h)
    Template.render(env, "accounts/users/index.html.j2", users: users)
  end

  def show(env)
    user_id = env.params.url["user_id"]
    if user = Accounts.get_user(user_id)
      Template.render(env, "accounts/users/show.html.j2", user: user.to_h)
    else
      env.redirect("/users")
    end
  end

  def _new(env)
    user = Accounts.new_user()
    Template.render(env, "accounts/users/new.html.j2", user: user.to_h)
  end

  def create(env)
    Accounts.create_user(env.params.body)
    env.redirect("/users")
  end

  def edit(env)
    user_id = env.params.url["user_id"]
    if user = Accounts.get_user(user_id)
      Template.render(env, "accounts/users/edit.html.j2", user: user.to_h)
    else
      env.redirect("/users")
    end
  end

  def update(env)
    user_id = env.params.url["user_id"]
    if user = Accounts.get_user(user_id)
      Accounts.update_user(user, env.params.body)
    end

    env.redirect("/users")
  end
end
