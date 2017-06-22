# open current file
# $0 refers to the current file: print_source.rb
# read file "r"
# .readlines reads the entire file as individual lines and returns
# the lines as strings (including the \n) in an array.
# e.g. readlines[0] is "# open current file\n"
# next feed each element in readlines into the variable line
# print each line to screen
# call the method
def print_source
  File.open($0, "r") { |file| file.readlines.each { |line| puts line } }
end

print_source
