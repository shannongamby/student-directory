@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return"
  name = gets.chomp
  while !name.empty? do
    puts "And the cohort?"
    cohort = gets.chomp
    if cohort == ""
       cohort = "october"
    end
    @students << {name: name, cohort: cohort.to_sym}
    if @students.length == 1
      puts "Now we have #{@students.count} student. Enter another name."
    else
      puts "Now we have #{@students.count} students. Enter another name."
    end
    name = gets.chomp
  end
  return @students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_student_list
  grouped = {}
  @students.each { |h|
  if grouped.keys.include? h[:cohort]
    grouped[h[:cohort]].push(h[:name])
  else
    grouped[h[:cohort]] = [h[:name]]
  end
  }
  grouped.each { |cohort, names|
    puts "#{cohort} cohort: ".center(50)
    names.each { |name| puts name.center(50) }
    puts " "
  }
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each { |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  }
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each { |line|
    name, cohort = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym}
    }
  file.close
end

interactive_menu
print_header
print_student_list
print_footer
