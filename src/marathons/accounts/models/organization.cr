require "crypto/bcrypt/password"

module Accounts
  class Organization < Crecto::Model
    schema "acc_organizations" do
      field :name, String

      belongs_to :owner, User, foreign_key: :owner_id
    end

    field :hio, String


    validate_required :name
    validate_required :owner_id


    def password=(new_password : String)
      @encrypted_password = Crypto::Bcrypt::Password.create(new_password).to_s
      @password = new_password
    end

    def password_matches?(other_password : String)
      Crypto::Bcrypt::Password.new(@encrypted_password.not_nil!) == other_password
    end


    def to_h
      {
        "id" => id,
        "name" => name,
        "owner_id" => owner_id,
        "owner" => owner_id ? owner.to_h : nil
      }
    end
  end
end
