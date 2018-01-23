class ApiController < ApplicationController
  
  def create 
    
    =begin Handle NFC
    if params[:type] == "nfc" && params[:data] 
      student = Student.find_by(card_id: nfc_data)
      
    end
    =end
  end


  def validate
    render :json => {:success => 1, :student_name => "Test", :course_title => "Test course" }
  end
end