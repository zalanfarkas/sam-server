# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
zalan = Student.create!(fingerprint_template: '123|32|14', email: 'zalan@example.com', password: 'password', sam_student_id: '12345678', first_name: 'Zalan', last_name: 'Farkas', card_id: '200139105217243', picture: File.open(Rails.root + "app/assets/images/guy1.jpeg"))
#Zalan with Profile Picture
#zalan = Student.create!(fingerprint_template: '123|32|14', email: 'zalan@example.com', password: 'password', sam_student_id: '001', first_name: 'Zalan', last_name: 'Farkas', card_id: '200139105217243', picture: Rails.root.join("public/cat-icon.png").open)
edvinas = Student.create!(fingerprint_template: '3|1|92|7|132|0|255|254|255|254|255|254|255|254|255|254|255|254|254|14|252|6|248|6|248|2|240|2|224|0|224|0|224|0|224|0|224|0|224|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|81|29|153|190|92|175|215|158|34|58|195|158|44|193|217|158|63|36|194|127|91|51|236|191|117|186|212|58|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', email: 'ed@example.com', password: 'password', sam_student_id: '11111111', first_name: 'Edvinas', last_name: 'Byla', card_id: '0000', picture: File.open(Rails.root + "app/assets/images/guy2.jpeg"))
dovydas = Student.create!(fingerprint_template: '123|32|12', email: 'dovydas@example.com', password: 'password', sam_student_id: '22222222', first_name: 'Dovydas', last_name: 'Pekus', card_id: '226198141759', picture: File.open(Rails.root + "app/assets/images/guy1.jpeg"))

#staff with two courses
nir = Staff.create!(fingerprint_template: '123|32|11', email: 'nir@example.com', password: 'password', sam_staff_id: "s_00000001", first_name: 'Nir', last_name: 'Oren', card_id: 'u00000003')

#staff without any courses
matthew = Staff.create!(fingerprint_template: '', email: 'matthew@example.com', password: 'password', sam_staff_id: "s_002", first_name: 'Matthew', last_name: 'Collinson', card_id: 'u00013')

#student who is not a demonstrator
patrik = Student.create!(email: 'patrik@example.com', password: 'password', sam_student_id: '33333333', first_name: 'Patrik', last_name: 'Bansky', card_id: '000088', picture: File.open(Rails.root + "app/assets/images/guy2.jpeg"))


robotics = nir.courses.create!(sam_course_id: 'CS3001', course_title: 'Robotics')
awad = nir.courses.create!(sam_course_id: 'CS3002', course_title: 'AWAD')


Enrolment.create(course_id: robotics.id, student_id: edvinas.id)
Enrolment.create(course_id: robotics.id, student_id: zalan.id)

Enrolment.create(course_id: robotics.id, student_id: patrik.id)
Enrolment.create(course_id: awad.id, student_id: patrik.id)



#start_time = 1.month.ago
#end_time = start_time + 2.month
#robot_test = DateTime.now - 4.days

#awad_practical = awad.practicals.create(start_time: 7.days.ago, end_time: DateTime.now+1.week, location: "Meston 311")
#awad_practical2 = awad.practicals.create(start_time: DateTime.now, end_time: DateTime.now+2.weeks, location: "Meston 205")
#robotics_practical = robotics.practicals.create(start_time: start_time, end_time: end_time, location: "FN115")

#upcoming practicals
#robotics_practical2 = robotics.practicals.create(start_time: start_time + 2.month, end_time: end_time, location: "MR117")

#next week's Monday:
this_monday = DateTime.now.beginning_of_week
next_monday = DateTime.now.next_week.next_day(0)

#awad practicals:
#past practicals:
awad_practical_week1_1 = awad.practicals.create(start_time: this_monday - 5.week, end_time: this_monday - 5.week + 2.hours, location: "Meston 311")
awad_practical_week1_2 = awad.practicals.create(start_time: this_monday - 5.week + 1.day, end_time: this_monday - 5.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week1_3 = awad.practicals.create(start_time: this_monday - 5.week + 3.day, end_time: this_monday - 5.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week2_1 = awad.practicals.create(start_time: this_monday - 4.week, end_time: this_monday - 4.week + 2.hours, location: "Meston 311")
awad_practical_week2_2 = awad.practicals.create(start_time: this_monday - 4.week + 1.day, end_time: this_monday - 4.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week2_3 = awad.practicals.create(start_time: this_monday - 4.week + 3.day, end_time: this_monday - 4.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week3_1 = awad.practicals.create(start_time: this_monday - 3.week, end_time: this_monday - 3.week + 2.hours, location: "Meston 311")
awad_practical_week3_2 = awad.practicals.create(start_time: this_monday - 3.week + 1.day, end_time: this_monday - 3.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week3_3 = awad.practicals.create(start_time: this_monday - 3.week + 3.day, end_time: this_monday - 3.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week4_1 = awad.practicals.create(start_time: this_monday - 2.week, end_time: this_monday - 2.week + 2.hours, location: "Meston 311")
awad_practical_week4_2 = awad.practicals.create(start_time: this_monday - 2.week + 1.day, end_time: this_monday - 2.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week4_3 = awad.practicals.create(start_time: this_monday - 2.week + 3.day, end_time: this_monday - 2.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week5_1 = awad.practicals.create(start_time: this_monday - 1.week, end_time: this_monday - 1.week + 2.hours, location: "Meston 311")
awad_practical_week5_2 = awad.practicals.create(start_time: this_monday - 1.week + 1.day, end_time: this_monday - 1.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week5_3 = awad.practicals.create(start_time: this_monday - 1.week + 3.day, end_time: this_monday - 1.week + 3.day + 2.hours, location: "Meston 205")

#this week's practicals:
awad_practical_week6_1 = awad.practicals.create(start_time: this_monday, end_time: this_monday + 2.hours, location: "Meston 311")
awad_practical_week6_2 = awad.practicals.create(start_time: this_monday + 1.day, end_time: this_monday + 1.day + 2.hours, location: "Meston 205")
awad_practical_week6_3 = awad.practicals.create(start_time: DateTime.now, end_time: DateTime.now + 2.hours, location: "Meston 205")

#future practicals:
awad_practical_week7_1 = awad.practicals.create(start_time: next_monday + 7.week, end_time: next_monday + 7.week + 2.hours, location: "Meston 311")
awad_practical_week7_2 = awad.practicals.create(start_time: next_monday + 7.week + 1.day, end_time: next_monday + 7.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week7_3 = awad.practicals.create(start_time: next_monday + 7.week + 3.day, end_time: next_monday + 7.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week8_1 = awad.practicals.create(start_time: next_monday + 8.week, end_time: next_monday + 8.week + 2.hours, location: "Meston 311")
awad_practical_week8_2 = awad.practicals.create(start_time: next_monday + 8.week + 1.day, end_time: next_monday + 8.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week8_3 = awad.practicals.create(start_time: next_monday + 8.week + 3.day, end_time: next_monday + 8.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week9_1 = awad.practicals.create(start_time: next_monday + 9.week, end_time: next_monday + 9.week + 2.hours, location: "Meston 311")
awad_practical_week9_2 = awad.practicals.create(start_time: next_monday + 9.week + 1.day, end_time: next_monday + 9.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week9_3 = awad.practicals.create(start_time: next_monday + 9.week + 3.day, end_time: next_monday + 9.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week10_1 = awad.practicals.create(start_time: next_monday + 10.week, end_time: next_monday + 10.week + 2.hours, location: "Meston 311")
awad_practical_week10_2 = awad.practicals.create(start_time: next_monday + 10.week + 1.day, end_time: next_monday + 10.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week10_3 = awad.practicals.create(start_time: next_monday + 10.week + 3.day, end_time: next_monday + 10.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week11_1 = awad.practicals.create(start_time: next_monday + 11.week, end_time: next_monday + 11.week + 2.hours, location: "Meston 311")
awad_practical_week11_2 = awad.practicals.create(start_time: next_monday + 11.week + 1.day, end_time: next_monday + 11.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week11_3 = awad.practicals.create(start_time: next_monday + 11.week + 3.day, end_time: next_monday + 11.week + 3.day + 2.hours, location: "Meston 205")

#robotics practicals:
robotics_practical_week1_1 = robotics.practicals.create(start_time: this_monday - 5.week, end_time: this_monday - 5.week + 2.hours, location: "Meston 311")
robotics_practical_week1_2 = robotics.practicals.create(start_time: this_monday - 5.week + 1.day, end_time: this_monday - 5.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week1_3 = robotics.practicals.create(start_time: this_monday - 5.week + 3.day, end_time: this_monday - 5.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week2_1 = robotics.practicals.create(start_time: this_monday - 4.week, end_time: this_monday - 4.week + 2.hours, location: "Meston 311")
robotics_practical_week2_2 = robotics.practicals.create(start_time: this_monday - 4.week + 1.day, end_time: this_monday - 4.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week2_3 = robotics.practicals.create(start_time: this_monday - 4.week + 3.day, end_time: this_monday - 4.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week3_1 = robotics.practicals.create(start_time: this_monday - 3.week, end_time: this_monday - 3.week + 2.hours, location: "Meston 311")
robotics_practical_week3_2 = robotics.practicals.create(start_time: this_monday - 3.week + 1.day, end_time: this_monday - 3.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week3_3 = robotics.practicals.create(start_time: this_monday - 3.week + 3.day, end_time: this_monday - 3.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week4_1 = robotics.practicals.create(start_time: this_monday - 2.week, end_time: this_monday - 2.week + 2.hours, location: "Meston 311")
robotics_practical_week4_2 = robotics.practicals.create(start_time: this_monday - 2.week + 1.day, end_time: this_monday - 2.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week4_3 = robotics.practicals.create(start_time: this_monday - 2.week + 3.day, end_time: this_monday - 2.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week5_1 = robotics.practicals.create(start_time: this_monday - 1.week, end_time: this_monday - 1.week + 2.hours, location: "Meston 311")
robotics_practical_week5_2 = robotics.practicals.create(start_time: this_monday - 1.week + 1.day, end_time: this_monday - 1.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week5_3 = robotics.practicals.create(start_time: this_monday - 1.week + 3.day, end_time: this_monday - 1.week + 3.day + 2.hours, location: "Meston 205")

#this week's practicals
robotics_practical_week6_1 = robotics.practicals.create(start_time: this_monday, end_time: this_monday + 2.hours, location: "Meston 311")
robotics_practical_week6_2 = robotics.practicals.create(start_time: this_monday + 1.day, end_time: this_monday + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week6_3 = robotics.practicals.create(start_time: DateTime.now, end_time: DateTime.now + 2.hours, location: "Meston 205")

#future practicals
robotics_practical_week7_1 = robotics.practicals.create(start_time: next_monday + 7.week, end_time: next_monday + 7.week + 2.hours, location: "Meston 311")
robotics_practical_week7_2 = robotics.practicals.create(start_time: next_monday + 7.week + 1.day, end_time: next_monday + 7.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week7_3 = robotics.practicals.create(start_time: next_monday + 7.week + 3.day, end_time: next_monday + 7.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week8_1 = robotics.practicals.create(start_time: next_monday + 8.week, end_time: next_monday + 8.week + 2.hours, location: "Meston 311")
robotics_practical_week8_2 = robotics.practicals.create(start_time: next_monday + 8.week + 1.day, end_time: next_monday + 8.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week8_3 = robotics.practicals.create(start_time: next_monday + 8.week + 3.day, end_time: next_monday + 8.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week9_1 = robotics.practicals.create(start_time: next_monday + 9.week, end_time: next_monday + 9.week + 2.hours, location: "Meston 311")
robotics_practical_week9_2 = robotics.practicals.create(start_time: next_monday + 9.week + 1.day, end_time: next_monday + 9.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week9_3 = robotics.practicals.create(start_time: next_monday + 9.week + 3.day, end_time: next_monday + 9.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week10_1 = robotics.practicals.create(start_time: next_monday + 10.week, end_time: next_monday + 10.week + 2.hours, location: "Meston 311")
robotics_practical_week10_2 = robotics.practicals.create(start_time: next_monday + 10.week + 1.day, end_time: next_monday + 10.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week10_3 = robotics.practicals.create(start_time: next_monday + 10.week + 3.day, end_time: next_monday + 10.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week11_1 = robotics.practicals.create(start_time: next_monday + 11.week, end_time: next_monday + 11.week + 2.hours, location: "Meston 311")
robotics_practical_week11_2 = robotics.practicals.create(start_time: next_monday + 11.week + 1.day, end_time: next_monday + 11.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week11_3 = robotics.practicals.create(start_time: next_monday + 11.week + 3.day, end_time: next_monday + 11.week + 3.day + 2.hours, location: "Meston 205")


#Demonstrator: Dovydas
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: robotics_practical_week1_1.id)
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: awad_practical_week1_1.id)
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: awad_practical_week2_1.id)

#Demonstrator: Zalan
Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: awad_practical_week1_1.id)
Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: awad_practical_week2_1.id)

#Attendance.create!(student_id: zalan.id, practical_id: robotics_practical.id)

AbsenceCertificate.create!(course_id: 1, student_id: 1, certificate_type: "C6")
AbsenceCertificate.create!(course_id: 1, student_id: 2, certificate_type: "C6")
AbsenceCertificate.create!(course_id: 2, student_id: 2, certificate_type: "C6")


practicals = Course.first.practicals
practicals_on_specific_weeks_for_course1 = [[]]
index = 0
week_number = practicals.first.start_time.strftime("%U").to_i
practicals.each do |practical|
  if practical.start_time.strftime("%U").to_i != week_number
    week_number = practical.start_time.strftime("%U").to_i
    index += 1
    practicals_on_specific_weeks_for_course1[index] = []  
  end
practicals_on_specific_weeks_for_course1[index] << practical
end

practicals = Course.second.practicals
practicals_on_specific_weeks_for_course2 = [[]]
index = 0
week_number = practicals.first.start_time.strftime("%U").to_i
practicals.each do |practical|
  if practical.start_time.strftime("%U").to_i != week_number
    week_number = practical.start_time.strftime("%U").to_i
    index += 1
    practicals_on_specific_weeks_for_course2[index] = []  
  end
practicals_on_specific_weeks_for_course2[index] << practical
end
#p practicals_on_specific_weeks_for_course1.inspect

picture_array = ['guy1.jpeg','guy2.jpeg']
#creating students who are enrolled for courses and attended on practicals
60.times do |i|
  student = Student.create!(email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, card_id: Faker::Number.number(10), sam_student_id: Faker::Number.number(8), picture: File.open(Rails.root + "app/assets/images/#{picture_array[i%2]}") )
  Enrolment.create!(course_id: 1, student_id: student.id)
  Enrolment.create!(course_id: 2, student_id: student.id)
  practicals_on_specific_weeks_for_course1.each do |practical_number1|
    # work only with 3practicals/week
    Attendance.create!(student_id: student.id, practical_id: practical_number1[Faker::Number.between(0, 2)].id)
  end
  practicals_on_specific_weeks_for_course2.each do |practical_number2|
    # work only with 3practicals/week
    Attendance.create!(student_id: student.id, practical_id: practical_number2[Faker::Number.between(0, 2)].id)
  end
end
