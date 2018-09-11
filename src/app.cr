require "pg"
require "crecto"
require "dotenv"

require "./marathons/**"
require "./marathons_web/**"

# users = Accounts.list_users(Query.where(name: "Jon"))

# if users.empty?
#   user = Accounts.create_user(name: "Jon", password: "something")
#   puts user.instance.to_json
# else
#   puts users
# end

# org = Accounts.create_organization(name: "Something")

# puts org.instance.to_json
# puts org.errors

# env = Dotenv.load!
