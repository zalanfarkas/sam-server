class ApiController < ApplicationController
  def validate
    
    
    render :json => {:success => 1, :student_name => "Test", :course_title => "Test course" }
  end
end