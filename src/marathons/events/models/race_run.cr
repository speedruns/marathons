require "../../util/time.cr"

module Events
  class RaceRun < Crecto::Model
    schema "ev_race_runs" do
      belongs_to :race, Race
      belongs_to :run, Run
    end
  end
end
