class Course < ApplicationRecord
  belongs_to :staff
  has_many :practicals
  has_many :enrolments
end
