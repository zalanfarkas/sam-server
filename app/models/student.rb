# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# class to represent entries of the students table 
class Student < ApplicationRecord
  
  #configuration of the Devise authentication library
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :rememberable
  devise :database_authenticatable, :lockable, :timeoutable,
         :recoverable, :trackable, :validatable
  
  # specifying relationships       
  has_many :attendances
  has_many :enrolments
  has_many :practicals, through: :attendances
  has_many :absence_certificates
  
  #handling file field of the database entry
  mount_uploader :picture, PictureUploader
  
  # validation of fields of the entry
  validate  :picture_size
  validates :sam_student_id, presence: true, uniqueness: true
  validates :card_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  private
  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
