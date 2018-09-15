require "pg"
require "crecto"

module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter = Crecto::Adapters::Postgres
    conf.hostname = "localhost"
    conf.database = "marathons"
  end
end

alias Query = Crecto::Repo::Query
alias Multi = Crecto::Multi

Crecto::DbLogger.set_handler(STDOUT)
