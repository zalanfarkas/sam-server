class Practical < ApplicationRecord
  belongs_to :course
  
  has_many :demonstrators
  has_many :attendances
  has_many :students, through: :attendances
  
  def validate(record)
    if !record.start_time.nil? && !record.end_time.nil? && record.start_time >= record.end_time
      record.errors[:end_time] << 'End date should be greater that start date!'
    end
  
    if !record.start_time.nil? && record.start_time < Time.now
      record.errors[:start_time] << 'Start time must be greater than current time'
    end
  end
  
end
