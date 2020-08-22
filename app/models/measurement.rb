class Measurement < ApplicationRecord
  # model association
  # belongs_to :step

  # validation
  validates_presence_of :steps_recorded
end
