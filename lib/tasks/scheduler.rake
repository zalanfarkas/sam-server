# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# task called by a cron job of the hosting environment 
# it checks whether the student attended 
# at least one practical for each of their courses
# if not, it issues a absence certificate (interts it into the database)
# and it also sends a notification about the missed practicals to the student by email

# to send emails, it calls the student_mailer class declared in app/mailers/student_mailer.rb


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
            # If there were no practicals last week then skip that course
            next if practicals.count == 0
            # Look through each practical for the attendance
            practicals.each do |practical|
               if practical.students.exists?(:id => student.id)
                   found = true
               end
            end
            
            if found == false
                # Give c6 and send and email about it
                AbsenceCertificate.create(student_id: student.id, course_id: enrolment.course.id, certificate_type: "C6")
                StudentMailer.absense_notification(student, enrolment.course).deliver_now
            end
        end
    end
end