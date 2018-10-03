module OrganizationsController
  extend self

  def index(env)
    orgs = Accounts.list_organizations(Query.preload(:owner))
    orgs = orgs.map(&.to_h)
    Template.render(env, "accounts/organizations/index.html.j2", {
      "orgs" => orgs
    })
  end

  def show(env)
    org_id = env.params.url["org_id"]
    if org = Accounts.get_organization(org_id, Query.preload(:owner))
      Template.render(env, "accounts/organizations/show.html.j2", {
        "org" => org.to_h
      })
    else
      env.redirect("/organizations")
    end
  end

  def _new(env)
    org = Accounts.new_organization()
    users = Accounts.list_users().map{ |u| {name: u.name, id: u.id} }
    Template.render(env, "accounts/organizations/new.html.j2", {
      "org" => org.to_h,
      "users" => users
    })
  end

  def create(env)
    params = env.params.body
    Accounts.create_organization(params)
    env.redirect("/organizations")
  end

  def edit(env)
    org_id = env.params.url["org_id"]
    if org = Accounts.get_organization(org_id, Query.preload(:owner))
      users = Accounts.list_users().map{ |u| {name: u.name, id: u.id} }
      Template.render(env, "accounts/organizations/edit.html.j2", {
        "org" => org.to_h,
        "users" => users
      })
    else
      env.redirect("/organizations")
    end
  end

  def update(env)
    org_id = env.params.url["org_id"]
    if org = Accounts.get_organization(org_id)
      Accounts.update_organization(org, env.params.body)
    end

    env.redirect("/organizations")
  end

  def destroy(env)
    org_id = env.params.url["org_id"]
    if org = Accounts.get_organization(org_id)
      Accounts.delete_organization(org)
    end

    env.redirect("/organizations")
  end
end
