class AbsenceCertificate < ApplicationRecord
  belongs_to :student
  belongs_to :course
  
  validates :certificate_type, presence: true, inclusion: { in: %w(C6 C7), message: "%{value} is not a valid value" }
end
