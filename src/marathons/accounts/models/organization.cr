require "crypto/bcrypt/password"

module Accounts
  class Organization < Crecto::Model
    schema "acc_organizations" do
      field :name, String

      belongs_to :owner, User, foreign_key: :owner_id
    end

    validate_required :name
    validate_required :owner_id


    def to_h
      {
        "id" => id,
        "name" => name,
        "owner_id" => owner_id,
        "owner" => owner?.try(&.to_h)
      }
    end
  end
end
