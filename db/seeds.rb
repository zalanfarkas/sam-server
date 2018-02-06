# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

zalan = Student.create!(sam_student_id: '00000001', first_name: 'Zalan', last_name: 'Farkas', card_id: 'u00000001')
dovydas = Student.create!(sam_student_id: '00000002', first_name: 'Dovydas', last_name: 'Pekus', card_id: 'u00000002')
nir = Staff.create!(sam_staff_id: "s_00000001", first_name: 'Nir', last_name: 'Oren', card_id: 'u00000002')

robotics = nir.courses.create!(sam_course_id: 'CS3001', course_title: 'Robotics')

start_time = DateTime.now + 1.week
end_time = start_time + 1.hour
robotics_practical = robotics.practicals.create(start_time: start_time, end_time: end_time)

Attendance.create!(student_id: zalan.id, practical_id: robotics_practical.id)

Enrolment.create(course_id: robotics.id, student_id: zalan.id)


Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: robotics_practical.id)