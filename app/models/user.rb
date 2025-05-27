class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  # Override to prevent session serialization (optional)
  def self.serialize_into_session(record)
    # no-op, disable session serialization
  end
end


