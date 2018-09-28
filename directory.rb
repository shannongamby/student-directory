require 'csv'
@students = []

def start_program
  try_load_students
  interactive_menu
end

def interactive_menu
  loop do
    print_menu
    process_user_selection(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "5. Exit"
end

def process_user_selection(selection)
  case selection
  when "1"
    input_students_info
  when "2"
    show_students
  when "3"
    puts "What do you want to call your file?"
    filename = STDIN.gets.chomp
    save_students(filename)
    puts "Saved to #{filename}"
  when "4"
    puts "Which file would you like to load?"
    filename = STDIN.gets.chomp
    load_students(filename)
    puts "Loaded from #{filename}"
  when "5"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students_info
  puts "Please enter the names of the students"
  puts "To finish, just hit return"
  while true do
    name = STDIN.gets.chomp
    break if name.empty?
    puts "And the cohort?"
    cohort = STDIN.gets.chomp
    cohort = "october" if cohort == ""
    add_students(name, cohort)
    print_student_count(@students.count)
  end
  return @students
end

def print_student_count(student_count)
  if @students.length == 1
    puts "Now we have #{student_count} student. Enter another name."
  else
    puts "Now we have #{student_count} students. Enter another name."
  end
end

def show_students
  print_header
  print_student_list(group_students_by_cohort)
  print_footer
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def group_students_by_cohort
  grouped = {}
  @students.each { |h|
  if grouped.keys.include? h[:cohort]
    grouped[h[:cohort]].push(h[:name])
  else
    grouped[h[:cohort]] = [h[:name]]
  end
  }
  return grouped
end

def print_student_list(grouped)
  grouped.each { |cohort, names|
    puts "#{cohort} cohort: ".center(50)
    names.each { |name| puts name.center(50) }
    puts " "
  }
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end

def save_students(filename)
  CSV.open("#{filename}", "w") { |file|
    @students.each { |student|
      student_data = [student[:name], student[:cohort]]
      file << student_data
    }
  }
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) { |line|
    name, cohort = line
    add_students(name, cohort)
  }
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

start_program
