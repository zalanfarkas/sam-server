class Staff < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable, :registerable,
  devise :database_authenticatable, :lockable,
         :recoverable, :trackable, :validatable, :timeoutable, :rememberable
         
  has_many :courses
  validates :sam_staff_id, presence: true, uniqueness: true
  validates :card_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
