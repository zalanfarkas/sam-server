# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
zalan = Student.create!(fingerprint_template: '123|32|14', email: 'zalan@example.com', password: 'password', sam_student_id: 'u01', first_name: 'Zalan', last_name: 'Farkas', card_id: '200139105217243')
#Zalan with Profile Picture
#zalan = Student.create!(fingerprint_template: '123|32|14', email: 'zalan@example.com', password: 'password', sam_student_id: '001', first_name: 'Zalan', last_name: 'Farkas', card_id: '200139105217243', picture: Rails.root.join("public/cat-icon.png").open)
edvinas = Student.create!(fingerprint_template: '3|1|92|7|132|0|255|254|255|254|255|254|255|254|255|254|255|254|254|14|252|6|248|6|248|2|240|2|224|0|224|0|224|0|224|0|224|0|224|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|81|29|153|190|92|175|215|158|34|58|195|158|44|193|217|158|63|36|194|127|91|51|236|191|117|186|212|58|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', email: 'ed@example.com', password: 'password', sam_student_id: 'u02', first_name: 'Edvinas', last_name: 'Byla', card_id: '0000')
dovydas = Student.create!(fingerprint_template: '123|32|12', email: 'dovydas@example.com', password: 'password', sam_student_id: '00000002', first_name: 'Dovydas', last_name: 'Pekus', card_id: '226198141759')

#staff with two courses
nir = Staff.create!(fingerprint_template: '123|32|11', email: 'nir@example.com', password: 'password', sam_staff_id: "s_00000001", first_name: 'Nir', last_name: 'Oren', card_id: 'u00000003')

#staff without any courses
matthew = Staff.create!(fingerprint_template: '', email: 'matthew@example.com', password: 'password', sam_staff_id: "s_002", first_name: 'Matthew', last_name: 'Collinson', card_id: 'u00013')

#student who is not a demonstrator
patrik = Student.create!(email: 'patrik@example.com', password: 'password', sam_student_id: '088', first_name: 'Patrik', last_name: 'Bansky', card_id: '000088')


robotics = nir.courses.create!(sam_course_id: 'CS3001', course_title: 'Robotics')
awad = nir.courses.create!(sam_course_id: 'CS3002', course_title: 'AWAD')


Enrolment.create(course_id: robotics.id, student_id: edvinas.id)
Enrolment.create(course_id: robotics.id, student_id: zalan.id)

Enrolment.create(course_id: robotics.id, student_id: patrik.id)
Enrolment.create(course_id: awad.id, student_id: patrik.id)



start_time = 1.month.ago
end_time = start_time + 2.month
#robot_test = DateTime.now - 4.days

awad_practical = awad.practicals.create(start_time: 7.days.ago, end_time: DateTime.now+1.week, location: "Meston 311")
awad_practical2 = awad.practicals.create(start_time: DateTime.now, end_time: DateTime.now+2.weeks, location: "Meston 205")
robotics_practical = robotics.practicals.create(start_time: start_time, end_time: end_time, location: "FN115")

#upcoming practicals
robotics_practical2 = robotics.practicals.create(start_time: start_time + 2.month, end_time: end_time, location: "MR117")
awad_practical_week1_1 = awad.practicals.create(start_time: DateTime.now + 1.week, end_time: DateTime.now + 1.week + 2.hours, location: "Meston 311")
awad_practical_week1_2 = awad.practicals.create(start_time: DateTime.now + 1.week + 1.day, end_time: DateTime.now + 1.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week1_3 = awad.practicals.create(start_time: DateTime.now + 1.week + 3.day, end_time: DateTime.now + 1.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week2_1 = awad.practicals.create(start_time: DateTime.now + 2.week, end_time: DateTime.now + 2.week + 2.hours, location: "Meston 311")
awad_practical_week2_2 = awad.practicals.create(start_time: DateTime.now + 2.week + 1.day, end_time: DateTime.now + 2.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week2_3 = awad.practicals.create(start_time: DateTime.now + 2.week + 3.day, end_time: DateTime.now + 2.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week3_1 = awad.practicals.create(start_time: DateTime.now + 3.week, end_time: DateTime.now + 3.week + 2.hours, location: "Meston 311")
awad_practical_week3_2 = awad.practicals.create(start_time: DateTime.now + 3.week + 1.day, end_time: DateTime.now + 3.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week3_3 = awad.practicals.create(start_time: DateTime.now + 3.week + 3.day, end_time: DateTime.now + 3.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week4_1 = awad.practicals.create(start_time: DateTime.now + 4.week, end_time: DateTime.now + 4.week + 2.hours, location: "Meston 311")
awad_practical_week4_2 = awad.practicals.create(start_time: DateTime.now + 4.week + 1.day, end_time: DateTime.now + 4.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week4_3 = awad.practicals.create(start_time: DateTime.now + 4.week + 3.day, end_time: DateTime.now + 4.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week5_1 = awad.practicals.create(start_time: DateTime.now + 5.week, end_time: DateTime.now + 5.week + 2.hours, location: "Meston 311")
awad_practical_week5_2 = awad.practicals.create(start_time: DateTime.now + 5.week + 1.day, end_time: DateTime.now + 5.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week5_3 = awad.practicals.create(start_time: DateTime.now + 5.week + 3.day, end_time: DateTime.now + 5.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week6_1 = awad.practicals.create(start_time: DateTime.now + 6.week, end_time: DateTime.now + 6.week + 2.hours, location: "Meston 311")
awad_practical_week6_2 = awad.practicals.create(start_time: DateTime.now + 6.week + 1.day, end_time: DateTime.now + 6.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week6_3 = awad.practicals.create(start_time: DateTime.now + 6.week + 3.day, end_time: DateTime.now + 6.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week7_1 = awad.practicals.create(start_time: DateTime.now + 7.week, end_time: DateTime.now + 7.week + 2.hours, location: "Meston 311")
awad_practical_week7_2 = awad.practicals.create(start_time: DateTime.now + 7.week + 1.day, end_time: DateTime.now + 7.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week7_3 = awad.practicals.create(start_time: DateTime.now + 7.week + 3.day, end_time: DateTime.now + 7.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week8_1 = awad.practicals.create(start_time: DateTime.now + 8.week, end_time: DateTime.now + 8.week + 2.hours, location: "Meston 311")
awad_practical_week8_2 = awad.practicals.create(start_time: DateTime.now + 8.week + 1.day, end_time: DateTime.now + 8.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week8_3 = awad.practicals.create(start_time: DateTime.now + 8.week + 3.day, end_time: DateTime.now + 8.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week9_1 = awad.practicals.create(start_time: DateTime.now + 9.week, end_time: DateTime.now + 9.week + 2.hours, location: "Meston 311")
awad_practical_week9_2 = awad.practicals.create(start_time: DateTime.now + 9.week + 1.day, end_time: DateTime.now + 9.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week9_3 = awad.practicals.create(start_time: DateTime.now + 9.week + 3.day, end_time: DateTime.now + 9.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week10_1 = awad.practicals.create(start_time: DateTime.now + 10.week, end_time: DateTime.now + 10.week + 2.hours, location: "Meston 311")
awad_practical_week10_2 = awad.practicals.create(start_time: DateTime.now + 10.week + 1.day, end_time: DateTime.now + 10.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week10_3 = awad.practicals.create(start_time: DateTime.now + 10.week + 3.day, end_time: DateTime.now + 10.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week11_1 = awad.practicals.create(start_time: DateTime.now + 11.week, end_time: DateTime.now + 11.week + 2.hours, location: "Meston 311")
awad_practical_week11_2 = awad.practicals.create(start_time: DateTime.now + 11.week + 1.day, end_time: DateTime.now + 11.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week11_3 = awad.practicals.create(start_time: DateTime.now + 11.week + 3.day, end_time: DateTime.now + 11.week + 3.day + 2.hours, location: "Meston 205")

#Demonstrator: Dovydas
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: robotics_practical.id)
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: awad_practical.id)
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: awad_practical2.id)

#Demonstrator: Zalan
Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: awad_practical.id)
Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: awad_practical2.id)

Attendance.create!(student_id: zalan.id, practical_id: robotics_practical.id)

AbsenceCertificate.create!(course_id: 1, student_id: 1, certificate_type: "C6")
AbsenceCertificate.create!(course_id: 1, student_id: 2, certificate_type: "C6")
AbsenceCertificate.create!(course_id: 2, student_id: 2, certificate_type: "C6")

#creating students
60.times do |i|
  Student.create!(email: Faker::Internet.email, password: "password", first_name: Faker::Name.first_name. last_name: Faker::Name.last_name)
  
end