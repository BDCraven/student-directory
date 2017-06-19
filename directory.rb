def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []

  while true do
    puts "Please enter a name"
    name = gets.chomp
    break if name.empty?

    puts "Please enter #{name}'s hobbies"
    hobbies = gets.chomp

    puts "Please enter #{name}'s country of birth"
    birth_place = gets.chomp
    # add the student hash to the array
    students << {name: name, cohort: :november, hobbies: hobbies, birth_place: birth_place}
    puts "Now we have #{students.count} students"
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort); hobbies: #{student[:hobbies]}; place of birth: #{student[:birth_place]}."
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
