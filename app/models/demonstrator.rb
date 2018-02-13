class Demonstrator < ApplicationRecord
  belongs_to :practical
  
  def find_person
    person = nil
    person = Staff.find_by(sam_staff_id: self.sam_demonstrator_id)
    return person != nil ? person : Student.find_by(sam_student_id: self.sam_demonstrator_id)
  end
  
  def self.find_practicals(type, data)
    sam_demonstrator_id = nil
    person = nil
    case type 
    when "nfc"
      person = Staff.find_by(card_id: data)
      person = Student.find_by(card_id: data) if person == nil
    when "sam_id"
      person = Staff.find_by(sam_staff_id: data)
      person = Student.find_by(sam_student_id: data) if person == nil
    else 
      puts "NEEDS IMPLEMENTATION!!!"
    end
    
    if person.nil?
      puts "FUCKED"
      return nil
    elsif person.is_a?(Staff)
      sam_demonstrator_id = person.sam_staff_id
    elsif person.is_a?(Student)
      sam_demonstrator_id = person.sam_student_id
    end
    
    demonstrations = Demonstrator.where(["sam_demonstrator_id = ?", sam_demonstrator_id])
    puts person.inspect
    puts person.id
    puts demonstrations.inspect
    practicals = Array.new
    demonstrations.each do |demonstrator|
      practicals << demonstrator.practical
    end
    
    return Practical.where(id: practicals.map(&:id))
  end
  
  validates :sam_demonstrator_id, presence: true
end
