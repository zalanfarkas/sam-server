# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License


# class to represent entries of the demonstrator table 
class Demonstrator < ApplicationRecord
  # specifying relationships
  belongs_to :practical
  
  # checks whether the demonstrator is a student or a staff member
  def find_person
    person = nil
    person = Staff.find_by(sam_staff_id: self.sam_demonstrator_id)
    return person != nil ? person : Student.find_by(sam_student_id: self.sam_demonstrator_id)
  end
  
  # finds the practicals of the demontrator by considering the input type
  # e.g. NFC card's ID, fingerprint template or student ID number
  def self.find_practicals(type, data)
    sam_demonstrator_id = nil
    person = nil
    # checks input type and finds the demonstrator accordingly
    case type 
    when "nfc"
      person = Staff.find_by(card_id: data)
      person = Student.find_by(card_id: data) if person == nil
    when "sam_id"
      person = Staff.find_by(sam_staff_id: data)
      person = Student.find_by(sam_student_id: data) if person == nil
    when "fingerprint"
      person = Staff.find_by(fingerprint_template: data)
      person = Student.find_by(fingerprint_template: data) if person == nil
    else 
      puts "YOU ARE TRYING TYPE WHICH IS NOT IMPLEMETED YET"
    end
    
    # verifies that the demonstrator entry is found
    if person.nil?
      return nil
    elsif person.is_a?(Staff)
      sam_demonstrator_id = person.sam_staff_id
    elsif person.is_a?(Student)
      sam_demonstrator_id = person.sam_student_id
    end
    
    # finds practical ids which belongs to the demonstrator
    demonstrations = Demonstrator.where(["sam_demonstrator_id = ?", sam_demonstrator_id])
    practicals = Array.new
    # stores the actual practical instances
    demonstrations.each do |demonstrator|
      practicals << demonstrator.practical
    end
    
    return Practical.where(id: practicals.map(&:id))
  end
  
  # validation of fields of the entry
  validates :sam_demonstrator_id, presence: true
end
