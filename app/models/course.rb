# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# class to represent entries of the courses table 
class Course < ApplicationRecord
  # specifying relationships
  belongs_to :staff
  has_many :practicals
  has_many :enrolments
  has_many :absence_certificates
  
  # validation of fields of the entry
  validates :sam_course_id, presence: true, uniqueness: true
  validates :course_title, presence: true
end
