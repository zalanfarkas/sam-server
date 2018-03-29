# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# class to represent entries of the absence_certificates table 
class AbsenceCertificate < ApplicationRecord
  # specifying relationships
  belongs_to :student
  belongs_to :course
  
  # validation of fields of the entry
  validates :certificate_type, presence: true, inclusion: { in: %w(C6 C7), message: "%{value} is not a valid value" }
end
