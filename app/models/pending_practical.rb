# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# class to represent entries of the pending_practicals table 
class PendingPractical < ApplicationRecord
  # specifying relationships
  belongs_to :practical
end
