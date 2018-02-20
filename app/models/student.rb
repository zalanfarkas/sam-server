class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :attendances
  has_many :enrolments
  has_many :practicals, through: :attendances
    
  validates :sam_student_id, presence: true, uniqueness: true
  validates :card_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
