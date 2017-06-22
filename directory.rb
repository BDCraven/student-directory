@students = [] # an empty array accessible to all methods
require "csv"

def load_students_on_startup
  filename = ARGV.first || "students.csv" # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  unless File.exists?(filename)
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
  load_students(filename)
  #if File.exists?(filename) # if it exists
  #  load_students(filename)
  #else # if it doesn't exist
  #  puts "Sorry, #{filename} doesn't exist."
  #  exit  # quit the program
  #end
end

def print_menu
  puts "----Menu----"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a csv file"
  puts "4. Load the list from a csv file"
  puts "9. Exit" # because we'll be adding more items
  puts "------------"
end

def interactive_menu
  loop do
    print_menu
    menu(STDIN.gets.chomp)
  end
end

def menu(selection) # amend method name from process to menu to make clearer
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    filename_to_load
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_students(name)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  puts "Please enter the name of the file you wish to save to"
  filename = "#{STDIN.gets.chomp}.csv"
  # open the file for writing
  CSV.open(filename, "w") do |row|
    # open file using csv.open and block and pipe in row
    # iterate over the array of students
    # CSV populates each row using an array so we need to convert each hash
    # of students to an array so [{name: Bob, cohort: :november}] needs to
    # become ["Bob", :november]
    # so iterate over each hash of the students array - set student to hash
    # then append the hash values of the keys (name and cohort) to the row
    # CSV converts the array to a csv line in the filename.
    @students.each do |student|
      row << [student[:name], student[:cohort]]
      #csv_line = student_data.join(",")
      #file.puts csv_line
    end
  end
  puts "Saved #{@students.count} " + (@students.count == 1 ? "student" : "students") + " to #{filename}"
end
# open the file for reading

def filename_to_load
  loop do
    puts "Please enter the name of the file you wish to load or press enter to exit"
    filename = "#{STDIN.gets.chomp}.csv"
    return if filename == ""
    if File.exists?(filename)
      load_students(filename)
      break
    else
      puts "'#{filename.chomp(".csv")}' was not found."
    end
  end
end

def load_students(filename = "students.csv")
  loaded_students = 0
  #File.open(filename, "r") do |file| # file open using block
  # .readlines reads the entire file as individual lines and returns
  # the lines in an array.
  # next feed each element in readlines into the variable line
    #file.readlines.each do |line|
    # line points to a string with newline "\n" at the end
    # therefore need to chomp the \n and split the string at ","
    # the 2 variables are assigned to the 2 parts of the split string.
    # With CSV we bypass the need for opening the file and reading each line.
    # CSV opens the file and passes each line to line as an array of items
    # seperated at the comma so line is ["name", "cohort"]
  CSV.foreach(filename) do |line|
    name = line[0] # to set our variables we assign them to the index of the array in line
    cohort = line[1]
    if !@students.any?{|student| student[:name] == name}
    # iterate over students to see if name not present in students.
    # if not present then we can call add_students.
    add_students(name, cohort)
    loaded_students +=1
    end
  end
  puts "Loaded #{loaded_students.to_s} new " + (loaded_students == 1 ? "student" : "students") + " from #{filename}"
end

def add_students(name, cohort = :november)
  # add name and cohort as hash to @students
  @students << {name: name, cohort: cohort.to_sym}
end

load_students_on_startup
interactive_menu
