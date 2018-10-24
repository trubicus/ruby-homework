class Employee
  attr_accessor :full_name
  attr_accessor :id

  def initialize(full_name, id)
    @full_name = full_name
    @id = id
  end

  def surname
    @full_name.split(' ', 2).last
  end

  def first_name
    @full_name.split(' ', 2).first
  end
end

class Programmer < Employee
  attr_accessor :languages

  def initialize(full_name, id, languages)
    super(full_name, id)
    @languages = languages
  end
end

class OfficeManager < Employee
  attr_accessor :office
  def initialize(full_name, id, office)
    super(full_name, id)
    @office = office
  end
end

def add_employee(employees)
  puts '[Add an employee]'
  puts 'a - to add a regular employee'
  puts 'e - to add a programmer'
  puts 'o - to add a office manager'
  print 'who do you want to add? '
  action = gets.chomp
  print 'Full name: '
  full_name = gets.chomp
  print 'ID: '
  id = gets.chomp

  case action
  when 'a' then employee = Employee.new(full_name, id)
  when 'e' 
    print 'Languages: '
    languages = gets.chomp.split(" ")
    employee = Programmer.new(full_name, id, languages)
  when 'o'
    print 'Office: '
    office = gets.chomp
    employee = OfficeManager.new(full_name, id, office)
  end

  employees << employee
end

def view_employees(employees)
  print "Sort by [f]irst name or [l]ast name? "
  sort_order = gets.chomp
  sorted_employees(employees, sort_order).each do |employee|
    print "#{employee.full_name}, #{employee.id}"
    case employee
    when Programmer then puts ", #{employee.languages}"
    when OfficeManager then puts ", #{employee.office}"
    else puts ""
    end
  end
end

def sorted_employees(employees, sort_order)
  employees.sort_by do |employee|
    if sort_order == "l"
      employee.surname
    elsif sort_order == "f"
      employee.first_name
    else
      puts "Wrong letter"
      break
    end
  end
end

def quit
  puts 'Goodbye!'
  exit
end

def print_help
  puts '[HELP]'
  puts 'Enter one of the following:'
  puts 'a - to add a new employee'
  puts 'v - to view existing employees'
  puts 'q - to quit the program'
  puts 'e - to edit existing employee'
end

def get_action
   gets.downcase[0]
end

def edit_employees(employees)
  puts "[Edit an employee]"
  print "ID of the emoloyee you want to edit: "
  id = gets.chomp
  employee = nil
  employee = employees.find {|i| i.id == id}
  puts "Current full name: #{employee.full_name}"
  print "New full name: "
  employee.full_name = gets.chomp
  puts "Current ID: #{employee.id}"
  print "New ID: "
  employee.id = gets.chomp
  case employee
  when Programmer
    puts "Current languages: #{employee.languages}"
    print "New Languages: "
    employee.languages = gets.chomp.split(" ")
  when OfficeManager
    puts "Current office: #{employee.office}"
    print "New Office: "
    employee.office = gets.chomp
  end
end

puts 'Employee-o-matic 4000'

employees = []

loop do
  print 'What do you want to do? '
  action = get_action

  case action
  when 'a' then add_employee(employees)
  when 'v' then view_employees(employees)
  when 'e' then edit_employees(employees)
  when 'q' then quit
  else
    print_help
  end
end
