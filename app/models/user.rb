class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :steps, foreign_key: :day_recorded
  # Validations
  validates_presence_of :name, :email, :password_digest
  validates_length_of :password_digest, minimum: 6
  validates_uniqueness_of :email
end
