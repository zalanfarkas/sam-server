# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# class to represent entries of the enrolment table 
class Enrolment < ApplicationRecord
  # specifying relationships
  belongs_to :course
  belongs_to :student
end
