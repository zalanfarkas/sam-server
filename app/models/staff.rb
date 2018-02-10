class Staff < ApplicationRecord
    has_many :courses
    
    validates :sam_staff_id, presence: true, uniqueness: true
    validates :card_id, presence: true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
end
