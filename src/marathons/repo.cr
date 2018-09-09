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

Query = Crecto::Repo::Query
Multi = Crecto::Repo::Multi
