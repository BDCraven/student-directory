def input_students
  puts "Please enter the names and cohorts of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  cohort_months = ["January", "February", "March", "April",
             "May", "June", "July", "August",
             "September", "October", "November", "December"]
  # get the first name
  # while the name is not empty, repeat this code
  while true do
    puts "Please enter the student's full name"
    name = gets.delete!("\n") # delete last return character. An alt to .chomp
    break if name.empty?

    puts "Please enter the month of the student's cohort or leave blank if you are not sure"
    cohort = gets.gsub("\n","").capitalize # substitute newline for empty
    # string. Another alternative to chomp.

    while !cohort_months.include?(cohort) && cohort != ""
      puts "That is not a recognised month please enter a month or leave blank if you are not sure"
      cohort = gets.chomp.capitalize
    end

    if cohort == ""
      cohort = "TBC"
    end
    # add the student hash to the array
    students << {name: name, cohort: cohort.to_sym}
    puts "Now we have #{students.count} " + (students.count > 1 ? "students" : "student")
    # get another name from the user
  end
  # return the array of students
  students
end
@line_width = 55
def print_header
  puts "The students of Villains Academy".center(@line_width)
  puts "-------------".center(@line_width)
end

def print(students, cohort = "") # if no cohort argument then default is empty.
  if cohort != "" # if not empty we select all students whose cohort matches the
    # argument supplied. Remember we converted the month from a string to a
    # symbol.
  students = students.select { |student| student[:cohort] == cohort}
  end
  students.sort_by {|cohort| cohort[:cohort]}.each do |student|
    puts "  #{student[:name]}".ljust(40) + "(#{student[:cohort]} cohort)".ljust(@line_width)
  end
end

def print_footer(students)
  puts "-------------".center(@line_width)
  puts ("Overall, we have #{students.count} great " + (students.count > 1 ? "students" : "student")).center(@line_width)
end

students = input_students
# nothing happens until we call the methods
print_header
print(students) # optional argument to sepecify cohort month.
print_footer(students)
