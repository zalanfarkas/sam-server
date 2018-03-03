# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

zalan = Student.create!(email: 'zalan@example.com', password: 'password', sam_student_id: '00000001', first_name: 'Zalan', last_name: 'Farkas', card_id: '200139105217243')
Student.create!(email: 'ed@example.com', password: 'password', sam_student_id: '00000099', first_name: 'Edvinas', last_name: 'Byla', card_id: '0000')
dovydas = Student.create!(email: 'dovydas@example.com', password: 'password', sam_student_id: '00000002', first_name: 'Dovydas', last_name: 'Pekus', card_id: '226198141759')
patrik = Student.create!(email: 'patrik@example.com', password: 'password', sam_student_id: '00000088', first_name: 'Patrik', last_name: 'Bansky', card_id: '000088')
nir = Staff.create!(email: 'ninja_hacker@example.com', password: 'password', sam_staff_id: "s_00000001", first_name: 'Nir', last_name: 'Oren', card_id: 'u00000003')

robotics = nir.courses.create!(sam_course_id: 'CS3001', course_title: 'Robotics')
awad = nir.courses.create!(sam_course_id: 'CS3002', course_title: 'AWAD')

start_time = DateTime.now
end_time = start_time + 1.month
robotics_practical = robotics.practicals.create(start_time: start_time, end_time: end_time)


Attendance.create!(student_id: zalan.id, practical_id: robotics_practical.id)

Enrolment.create(course_id: robotics.id, student_id: zalan.id)


awad_practical = awad.practicals.create(start_time: DateTime.now, end_time: DateTime.now+1.week)
awad_practical2 = awad.practicals.create(start_time: DateTime.now, end_time: DateTime.now+2.weeks)
Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: awad_practical2.id)


Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: robotics_practical.id)
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: awad_practical.id)
Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: awad_practical2.id)



Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: awad_practical.id)


