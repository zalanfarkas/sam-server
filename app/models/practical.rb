class Practical < ApplicationRecord
  belongs_to :course
  
  has_many :demonstrators
  has_many :attendances
  has_many :students, through: :attendances
end
