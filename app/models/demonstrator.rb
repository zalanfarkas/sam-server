class Demonstrator < ApplicationRecord
  belongs_to :practical
  
  def find_person
    person = nil
    person = Staff.find_by(sam_staff_id: self.sam_demonstrator_id)
    return person != nil ? person : Student.find_by(sam_student_id: self.sam_demonstrator_id)
  end
  
  
  def self.find_practicals(type, data)
    sam_demonstrator_id = nil
    case type 
    when "nfc"
      sam_demonstrator_id = Staff.find_by(card_id: data).sam_staff_id
      sam_demonstrator_id = Student.find_by(card_id: data).sam_student_id if sam_demonstrator_id == nil
    when "sam_id"
      person = Staff.find_by(sam_staff_id: data).sam_staff_id
      person = Student.find_by(sam_student_id: data).sam_student_id if sam_demonstrator_id == nil
    else 
      puts "NEEDS IMPLEMENTATION!!!"
    end
    
    demonstrations = Demonstrator.where(["sam_demonstrator_id = ?", sam_demonstrator_id])
    practicals = Array.new
    demonstrations.each do |demonstrator|
      practicals << demonstrator.practical
    end
    
    return Practical.where(id: practicals.map(&:id))
  end
  
  validates :sam_demonstrator_id, presence: true
end
