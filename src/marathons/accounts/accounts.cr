require "./models/**"

module Accounts
  extend self

  ###
  # Users
  ###

  def list_users(query : Query = Query.new)
    Repo.all(User, query)
  end

  def get_user(user_id, query : Query = Query.new)
    Repo.get(User, user_id, query)
  end

  def new_user()
    User.new
  end

  def create_user(attrs)
    user = User.new.cast(attrs)
    Repo.insert(user)
  end

  def update_user(user : User, changes)
    changeset = user.cast(changes)
    Repo.update(changeset)
  end


  ###
  # Organizations
  ###

  def list_organizations(query : Query = Query.new)
    Repo.all(Organization, query)
  end

  def get_organization(org_id, query : Query = Query.new)
    Repo.get(Organization, org_id, query)
  end

  def new_organization()
    Organization.new
  end

  def create_organization(attrs)
    org = Organization.new.cast(attrs)
    Repo.insert(org)
  end

  def update_organization(org : Organization, changes)
    changeset = org.cast(changes)
    Repo.update(changeset)
  end
end
