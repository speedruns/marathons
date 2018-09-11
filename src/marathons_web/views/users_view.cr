module UsersView
  extend AppView

  def users_json(users)
    JSON.build do |json|
      json.array do
        users.each do |user|
          json.object do
            json.field "name", user.name
            json.field "discord", user.discord
            json.field "twitch", user.twitch
            json.field "twitter", user.twitter
            json.field "timezone", user.timezone
            json.field "is_admin", user.admin
            json.field "avatar_object_id", user.avatar_object_id
          end
        end
      end
    end
  end
end
