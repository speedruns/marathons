require "crypto/bcrypt/password"

module Accounts
  class Organization < Crecto::Model
    schema "acc_organizations" do
      field :name, String

      belongs_to :owner, User, foreign_key: :owner_id
    end


    validate_required :name
    validate_required :owner


    def password=(new_password : String)
      @encrypted_password = Crypto::Bcrypt::Password.create(new_password).to_s
      @password = new_password
    end

    def password_matches?(other_password : String)
      Crypto::Bcrypt::Password.new(@encrypted_password.not_nil!) == other_password
    end
  end
end
