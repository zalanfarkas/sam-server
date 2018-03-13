class Course < ApplicationRecord
  belongs_to :staff
  has_many :practicals
  has_many :enrolments
  has_many :absence_certificates
  
  validates :sam_course_id, presence: true, uniqueness: true
  validates :course_title, presence: true
end
