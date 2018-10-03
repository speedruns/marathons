require "krout"

alias E = Krout::Env

macro crud(name, singular, controller)
  get   "/{{name.id}}", &->{{controller}}.index(E)
  get   "/{{name.id}}/new", &->{{controller}}._new(E)
  post  "/{{name.id}}/create", &->{{controller}}.create(E)
  get   "/{{name.id}}/:{{singular.id}}_id", &->{{controller}}.show(E)
  get   "/{{name.id}}/:{{singular.id}}_id/edit", &->{{controller}}.edit(E)
  post  "/{{name.id}}/:{{singular.id}}_id/update", &->{{controller}}.update(E)
  get   "/{{name.id}}/:{{singular.id}}_id/delete", &->{{controller}}.destroy(E)
end


###
# Admin
###

crud :users, "user", UsersController
crud :organizations, "org", OrganizationsController

crud :events, "event", EventsController
crud :organizers, "organizer", OrganizersController

crud :series, "series", SeriesController
crud :games, "game", GamesController
crud :categories, "category", CategoriesController


###
# Sessions
###

get   "/login", &->SessionsController._new(E)
post  "/login", &->SessionsController.create(E)
get   "/logout", &->SessionsController.delete(E)
