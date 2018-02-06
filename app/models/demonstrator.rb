class Demonstrator < ApplicationRecord
  belongs_to :practical
  
  def find_person
    person = nil
    person = Staff.find_by(sam_staff_id: self.sam_demonstrator_id)
    return person != nil ? person : Student.find_by(sam_student_id: self.sam_demonstrator_id)
  end
end
