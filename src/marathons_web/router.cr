require "krout"

alias E = Krout::Env


###
# Admin
###

# Users
get   "/users", &->UsersController.index(E)
get   "/users/new", &->UsersController._new(E)
post  "/users/create", &->UsersController.create(E)
get   "/users/:user_id", &->UsersController.show(E)
get   "/users/:user_id/edit", &->UsersController.edit(E)
post  "/users/:user_id/update", &->UsersController.update(E)


# Organizations
get   "/organizations", &->OrganizationsController.index(E)
get   "/organizations/new", &->OrganizationsController._new(E)
post  "/organizations/create", &->OrganizationsController.create(E)
get   "/organizations/:org_id", &->OrganizationsController.show(E)
get   "/organizations/:org_id/edit", &->OrganizationsController.edit(E)
post  "/organizations/:org_id/update", &->OrganizationsController.update(E)
