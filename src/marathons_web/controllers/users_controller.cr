module UsersController
  extend AppController

  def index(env)
    users = Accounts.list_users()
    render("users_json", users)
  end

  def new(env)
  end

  def create(env)
    Accounts.create_user(env.params.body)
    env.redirect("/users")
  end
end
