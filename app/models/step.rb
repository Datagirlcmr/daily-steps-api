class Step < ApplicationRecord

 # model association
 has_many :measurements, dependent: :destroy

 # validations
 validates_presence_of :title, :day_recorded
end
