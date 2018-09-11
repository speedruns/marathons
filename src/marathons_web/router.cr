require "krout"

alias E = Krout::Env


scope "/api" do
  before_all do |env|
    env.response.content_type = "application/json"
  end

  get   "/users", &->UsersController.index(E)
  post  "/users/create", &->UsersController.create(E)
end
