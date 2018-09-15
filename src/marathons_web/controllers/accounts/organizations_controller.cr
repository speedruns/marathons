module OrganizationsController
  extend self

  def index(env)
    orgs = Accounts.list_organizations(Query.preload(:owner))
    orgs = orgs.map(&.to_h)
    Template.render("accounts/organizations/index.html.j2", orgs: orgs)
  end

  def show(env)
    org_id = env.params.url["org_id"]
    if org = Accounts.get_organization(org_id, Query.preload(:owner))
      Template.render("accounts/organizations/show.html.j2", org: org.to_h)
    else
      env.redirect("/organizations")
    end
  end

  def _new(env)
    org = Accounts.new_organization()
    Template.render("accounts/organizations/new.html.j2", org: org.to_h)
  end

  def create(env)
    params = env.params.body
    params["owner_id"] = Accounts.list_users().first.id.to_s
    Accounts.create_organization(params)
    env.redirect("/organizations")
  end

  def edit(env)
    org_id = env.params.url["org_id"]
    if org = Accounts.get_organization(org_id, Query.preload(:owner))
      Template.render("accounts/organizations/edit.html.j2", org: org.to_h)
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
end
