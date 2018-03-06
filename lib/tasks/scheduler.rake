desc "Issue Absence Forms to sudents"
task :check_absence => :environment do
    current_time = DateTime.now
    # Go through each student
    Student.find_each do |student|
        # Go through each enrolment
        student.enrolments.each do |enrolment|
            found = false
            # Find all practicals for the previous week of that enrolment
            practicals = enrolment.course.practicals.where('start_time >= ? AND end_time <= ?', current_time - 7.days, current_time)
            practicals.each do |practical|
               if practical.students.exists?(:id => student.id)
                   found = true
               end
            end
            
            if found == false
                # Give c6
                puts "Student #{student.first_name} should get c6, because he missed practical for #{enrolment.course.course_title}"
            end
        end
    end
end