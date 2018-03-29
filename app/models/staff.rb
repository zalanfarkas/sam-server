# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# class to represent entries of the staffs table 
class Staff < ApplicationRecord
  
  #configuration of the Devise authentication library
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable, :registerable, :rememberable
  devise :database_authenticatable, :lockable,
         :recoverable, :trackable, :validatable, :timeoutable
   
  # specifying relationships      
  has_many :courses
  
  # validation of fields of the entry
  validates :sam_staff_id, presence: true, uniqueness: true
  validates :card_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
