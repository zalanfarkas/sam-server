class Student < ApplicationRecord
    has_many :attendances
    has_many :enrolments
    has_many :practicals, through: :attendances
end
