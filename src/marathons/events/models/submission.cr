module Events
  class Submission < Crecto::Model
    schema "ev_submissions" do
      belongs_to :event, Event
      belongs_to :account, Accounts::User

      has_many :runs, Submission::Run
      has_many :options, Submission::Option
    end
  end
end
