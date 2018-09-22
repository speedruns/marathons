module Accounts
  class Session < Crecto::Model
    schema "acc_sessions" do
      field :key, String
      field :valid, Bool, default: false

      belongs_to :user, User
    end

    def to_h
      {
        "valid" => valid,
        "user_id" => user_id,
        "user" => user? ? user.to_h : nil
      }
    end
  end
end
