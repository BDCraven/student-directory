def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  puts "Please enter the first letter of the name of the students you wish to print"
  first_name_let = gets.chomp
  results = 0
  if first_name_let == ""
    puts "No letter entered."
    exit
  elsif
    students.each_with_index do |student, student_number|
      if student[:name][0].downcase.include?(first_name_let.downcase)
        puts "#{student_number + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
        results += 1
      end
    end
  end
  if results == 0
      puts "We don't have any students starting with #{first_name_let}"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
# nothing happens until we call the methods
print_header
print(students)
print_footer(students)
