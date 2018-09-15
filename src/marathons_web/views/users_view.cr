module UsersView
  extend AppView

  def users_json(users)
    users.to_json
  end
end
