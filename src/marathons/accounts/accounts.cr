require "./models/**"

module Accounts
  extend self

  def create_user(**attrs)
    user = User.new.cast(attrs)
    Repo.insert(user)
  end

  def list_users(query = Query.new)
    Repo.all(User, query)
  end

  def create_organization(**attrs)
    organization = Organization.new.cast(attrs)
  end
end
