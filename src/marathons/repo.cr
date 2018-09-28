require "pg"
require "crecto"
require "dotenv"

Dotenv.load

module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter = Crecto::Adapters::Postgres
    conf.uri = ENV["DATABASE_URL"]
  end
end

alias Query = Crecto::Repo::Query
alias Multi = Crecto::Multi

Crecto::DbLogger.set_handler(STDOUT)
