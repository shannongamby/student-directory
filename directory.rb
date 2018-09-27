def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return"
  students = []
  name = gets.chomp
  while !name.empty? do
    puts "And the cohort?"
    cohort = gets.chomp
    if cohort == ""
       cohort = "october"
    end
    students << {name: name, cohort: cohort.to_sym, country: :UK}
    if students.length == 1
      puts "Now we have #{students.count} student. Enter another name."
    else
      puts "Now we have #{students.count} students. Enter another name."
    end
    name = gets.chomp
  end
  return students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  i = 0
  while i < students.size
    puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort, #{students[i][:country]})".center(50)
    i += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

students = input_students
print_header
print(students)
print_footer(students)
