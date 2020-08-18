class Step < ApplicationRecord
  # model association
  has_many :measurements, dependent: :destroy
  belongs_to :user

  # validations
  validates_presence_of :title, :day_recorded, steps_recorded
end
