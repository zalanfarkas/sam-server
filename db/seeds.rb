# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# used for seeding/bulding an example database to show use cases,
# boundary cases and to test the system

# students who are demonstrators
zalan = Student.create!(email: 'milkshake.9601@gmail.com', password: 'password', sam_student_id: '12345678', first_name: 'Zalan', last_name: 'Farkas', card_id: '13645246150', picture: File.open(Rails.root + "app/assets/images/guy1.jpeg"))
dovydas = Student.create!(email: 'dovydas@example.com', password: 'password', sam_student_id: '22222222', first_name: 'Dovydas', last_name: 'Pekus', card_id: '226198141759', picture: File.open(Rails.root + "app/assets/images/guy1.jpeg"))

#students who are not demonstrators
patrik = Student.create!(email: 'patrik@example.com', password: 'password', sam_student_id: '33333333', first_name: 'Patrik', last_name: 'Bansky', card_id: '000088', picture: File.open(Rails.root + "app/assets/images/pato.jpg"))
alex = Student.create!(email: 'alex@example.com', password: 'password', sam_student_id: '44444444', first_name: 'Alex', last_name: 'Ioana', card_id: '136419745100', picture: File.open(Rails.root + "app/assets/images/guy2.jpeg"))
vladimir = Student.create!(email: 'vladimir@example.com', password: 'password', sam_student_id: '55555555', first_name: 'Vladimir', last_name: 'Yesipov', card_id: '136421539124', picture: File.open(Rails.root + "app/assets/images/guy2.jpeg"))
edvinas = Student.create!(email: 'ed@example.com', password: 'password', sam_student_id: '11111111', first_name: 'Edvinas', last_name: 'Byla', card_id: '13642940185', picture: File.open(Rails.root + "app/assets/images/guy2.jpeg"))

#staff with two courses
nir = Staff.create!(email: 'nir@example.com', password: 'password', sam_staff_id: "s_00000001", first_name: 'Nir', last_name: 'Oren', card_id: 'u00000003')
robotics = nir.courses.create!(sam_course_id: 'CS3001', course_title: 'Robotics')
awad = nir.courses.create!(sam_course_id: 'CS3002', course_title: 'AWAD')

#staff without any courses
matthew = Staff.create!(email: 'matthew@example.com', password: 'password', sam_staff_id: "s_002", first_name: 'Matthew', last_name: 'Collinson', card_id: 'u00013')

# staff who is only demonstrator
jeff = Staff.create!(email: 'jeff@example.com', password: 'password', sam_staff_id: "s_008", first_name: 'Jeff', last_name: 'Smith', card_id: 'u00015')

# create enrolments
Enrolment.create(course_id: robotics.id, student_id: edvinas.id)
Enrolment.create(course_id: robotics.id, student_id: zalan.id)
Enrolment.create(course_id: robotics.id, student_id: patrik.id)
Enrolment.create(course_id: awad.id, student_id: patrik.id)
Enrolment.create(course_id: awad.id, student_id: edvinas.id)
Enrolment.create(course_id: awad.id, student_id: alex.id)
Enrolment.create(course_id: awad.id, student_id: zalan.id)

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
awad_practical_week7_1 = awad.practicals.create(start_time: next_monday, end_time: next_monday + 2.hours, location: "Meston 311")
awad_practical_week7_2 = awad.practicals.create(start_time: next_monday + 1.day, end_time: next_monday + 1.day + 2.hours, location: "Meston 205")
awad_practical_week7_3 = awad.practicals.create(start_time: next_monday + 3.day, end_time: next_monday + 3.day + 2.hours, location: "Meston 205")

awad_practical_week8_1 = awad.practicals.create(start_time: next_monday + 1.week, end_time: next_monday + 1.week + 2.hours, location: "Meston 311")
awad_practical_week8_2 = awad.practicals.create(start_time: next_monday + 1.week + 1.day, end_time: next_monday + 1.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week8_3 = awad.practicals.create(start_time: next_monday + 1.week + 3.day, end_time: next_monday + 1.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week9_1 = awad.practicals.create(start_time: next_monday + 2.week, end_time: next_monday + 2.week + 2.hours, location: "Meston 311")
awad_practical_week9_2 = awad.practicals.create(start_time: next_monday + 2.week + 1.day, end_time: next_monday + 2.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week9_3 = awad.practicals.create(start_time: next_monday + 2.week + 3.day, end_time: next_monday + 2.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week10_1 = awad.practicals.create(start_time: next_monday + 3.week, end_time: next_monday + 3.week + 2.hours, location: "Meston 311")
awad_practical_week10_2 = awad.practicals.create(start_time: next_monday + 3.week + 1.day, end_time: next_monday + 3.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week10_3 = awad.practicals.create(start_time: next_monday + 3.week + 3.day, end_time: next_monday + 3.week + 3.day + 2.hours, location: "Meston 205")

awad_practical_week11_1 = awad.practicals.create(start_time: next_monday + 4.week, end_time: next_monday + 4.week + 2.hours, location: "Meston 311")
awad_practical_week11_2 = awad.practicals.create(start_time: next_monday + 4.week + 1.day, end_time: next_monday + 4.week + 1.day + 2.hours, location: "Meston 205")
awad_practical_week11_3 = awad.practicals.create(start_time: next_monday + 4.week + 3.day, end_time: next_monday + 4.week + 3.day + 2.hours, location: "Meston 205")

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
robotics_practical_week7_1 = robotics.practicals.create(start_time: next_monday, end_time: next_monday  + 2.hours, location: "Meston 311")
robotics_practical_week7_2 = robotics.practicals.create(start_time: next_monday + 1.day, end_time: next_monday  + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week7_3 = robotics.practicals.create(start_time: next_monday  + 3.day, end_time: next_monday + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week8_1 = robotics.practicals.create(start_time: next_monday + 1.week, end_time: next_monday + 1.week + 2.hours, location: "Meston 311")
robotics_practical_week8_2 = robotics.practicals.create(start_time: next_monday + 1.week + 1.day, end_time: next_monday + 1.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week8_3 = robotics.practicals.create(start_time: next_monday + 1.week + 3.day, end_time: next_monday + 1.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week9_1 = robotics.practicals.create(start_time: next_monday + 2.week, end_time: next_monday + 2.week + 2.hours, location: "Meston 311")
robotics_practical_week9_2 = robotics.practicals.create(start_time: next_monday + 2.week + 1.day, end_time: next_monday + 2.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week9_3 = robotics.practicals.create(start_time: next_monday + 2.week + 3.day, end_time: next_monday + 2.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week10_1 = robotics.practicals.create(start_time: next_monday + 3.week, end_time: next_monday + 3.week + 2.hours, location: "Meston 311")
robotics_practical_week10_2 = robotics.practicals.create(start_time: next_monday + 3.week + 1.day, end_time: next_monday + 3.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week10_3 = robotics.practicals.create(start_time: next_monday + 3.week + 3.day, end_time: next_monday + 3.week + 3.day + 2.hours, location: "Meston 205")

robotics_practical_week11_1 = robotics.practicals.create(start_time: next_monday + 4.week, end_time: next_monday + 4.week + 2.hours, location: "Meston 311")
robotics_practical_week11_2 = robotics.practicals.create(start_time: next_monday + 4.week + 1.day, end_time: next_monday + 4.week + 1.day + 2.hours, location: "Meston 205")
robotics_practical_week11_3 = robotics.practicals.create(start_time: next_monday + 4.week + 3.day, end_time: next_monday + 4.week + 3.day + 2.hours, location: "Meston 205")


# groupping first course's practicals by week
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

# groupping first course's practicals by week
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

# adding demonstrators for practicals
Course.all.each do |course|
  course.practicals.each do |practical|
    Demonstrator.create!(sam_demonstrator_id: zalan.sam_student_id, practical_id: practical.id)
    Demonstrator.create!(sam_demonstrator_id: dovydas.sam_student_id, practical_id: practical.id)
    Demonstrator.create!(sam_demonstrator_id: jeff.sam_staff_id, practical_id: practical.id)
  end
end

# issuing absence certificates
AbsenceCertificate.create!(course_id: 1, student_id: 11, certificate_type: "C6")
AbsenceCertificate.create!(course_id: 1, student_id: 10, certificate_type: "C6")
AbsenceCertificate.create!(course_id: 2, student_id: 22, certificate_type: "C6")
