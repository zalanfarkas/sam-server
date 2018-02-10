class Demonstrator < ApplicationRecord
  belongs_to :practical
  
  def find_person
    person = nil
    person = Staff.find_by(sam_staff_id: self.sam_demonstrator_id)
    return person != nil ? person : Student.find_by(sam_student_id: self.sam_demonstrator_id)
  end
  
  def self.find_practicals_for(sam_demonstator_id)
    demonstrations = Demonstrator.where(["sam_demonstrator_id = ?", sam_demonstator_id])
    practicals = Array.new
    demonstrations.each do |demonstrator|
      practicals << demonstrator.practical
    end
    
    
    return Practical.where(id: practicals.map(&:id))
  end
  
  validates :sam_demonstrator_id, presence: true
end
