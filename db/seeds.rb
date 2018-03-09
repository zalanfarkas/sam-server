# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

zalan = Student.create!(fingerprint_template: '123|32|14', email: 'zalan@example.com', password: 'password', sam_student_id: '001', first_name: 'Zalan', last_name: 'Farkas', card_id: '200139105217243', picture: Rails.root.join("public/cat-icon.png").open)
edvinas = Student.create!(fingerprint_template: '3|1|92|7|132|0|255|254|255|254|255|254|255|254|255|254|255|254|254|14|252|6|248|6|248|2|240|2|224|0|224|0|224|0|224|0|224|0|224|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|81|29|153|190|92|175|215|158|34|58|195|158|44|193|217|158|63|36|194|127|91|51|236|191|117|186|212|58|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0', email: 'ed@example.com', password: 'password', sam_student_id: '00000099', first_name: 'Edvinas', last_name: 'Byla', card_id: '0000')
dovydas = Student.create!(fingerprint_template: '123|32|12', email: 'dovydas@example.com', password: 'password', sam_student_id: '00000002', first_name: 'Dovydas', last_name: 'Pekus', card_id: '226198141759')
patrik = Student.create!(email: 'patrik@example.com', password: 'password', sam_student_id: '00000088', first_name: 'Patrik', last_name: 'Bansky', card_id: '000088')
nir = Staff.create!(fingerprint_template: '123|32|11', email: 'nir@example.com', password: 'password', sam_staff_id: "s_00000001", first_name: 'Nir', last_name: 'Oren', card_id: '13645246150')

robotics = nir.courses.create!(sam_course_id: 'CS3001', course_title: 'Robotics')
awad = nir.courses.create!(sam_course_id: 'CS3002', course_title: 'AWAD')

start_time = DateTime.now
end_time = start_time + 1.month
#robot_test = DateTime.now - 4.days
robotics_practical = robotics.practicals.create(start_time: start_time, end_time: end_time)


Attendance.create!(student_id: zalan.id, practical_id: robotics_practical.id)

Enrolment.create(course_id: robotics.id, student_id: edvinas.id)
Enrolment.create(course_id: robotics.id, student_id: zalan.id)


awad_practical = awad.practicals.create(start_time: DateTime.now, end_time: DateTime.now+1.week)
awad_practical2 = awad.practicals.create(start_time: DateTime.now, end_time: DateTime.now+2.weeks)
Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: awad_practical2.id)


Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: robotics_practical.id)
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: awad_practical.id)
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: awad_practical2.id)



Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: awad_practical.id)


