# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# class to represent entries of the attendances table
class Attendance < ApplicationRecord
  # specifying relationships
  belongs_to :student
  belongs_to :practical
end
