def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return"
  students = []
  name = gets.tr("\n", "")
  while !name.empty? do
    puts "And the cohort?"
    cohort = gets.tr("\n", "")
    if cohort == ""
       cohort = "october"
    end
    students << {name: name, cohort: cohort.to_sym, country: :UK}
    if students.length == 1
      puts "Now we have #{students.count} student. Enter another name."
    else
      puts "Now we have #{students.count} students. Enter another name."
    end
    name = gets.tr("\n", "")
  end
  return students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  grouped = {}
  students.each { |h|
  if grouped.keys.include? h[:cohort]
    grouped[h[:cohort]].push(h[:name])
  else
    grouped[h[:cohort]] = [h[:name]]
  end
  }

  grouped.each { |cohort, names|
    puts "#{cohort} cohort: ".center(50)
    names.each { |name| puts name.center(50) }
  }
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

students = input_students
print_header
print(students)
print_footer(students)
