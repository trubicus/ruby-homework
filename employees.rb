# no-doc
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

# no-doc
class Programmer < Employee
  attr_accessor :languages

  def initialize(full_name, id, languages)
    super(full_name, id)
    @languages = languages
  end
end

# no-doc
class OfficeManager < Employee
  attr_accessor :office
  def initialize(full_name, id, office)
    super(full_name, id)
    @office = office
  end
end

def print_help_add
  puts '[Add an employee]'
  puts 'a - to add a regular employee'
  puts 'e - to add a programmer'
  puts 'o - to add a office manager'
end

def input_employee_details
  print 'Full name: '
  full_name = gets.chomp
  print 'ID: '
  id = gets.chomp
  [full_name, id]
end

def add_employee(employees)
  print_help_add
  print 'who do you want to add? '
  action = gets.chomp
  case action
  when 'a'
    full_name, id = input_employee_details
    employee = Employee.new(full_name, id)
  when 'e'
    full_name, id = input_employee_details
    print 'Languages: '
    languages = gets.chomp.split(' ')
    employee = Programmer.new(full_name, id, languages)
  when 'o'
    full_name, id = input_employee_details
    print 'Office: '
    office = gets.chomp
    employee = OfficeManager.new(full_name, id, office)
  else
    print_help_add
    return
  end
  employees << employee
end

def view_employees(employees)
  print 'Sort by [f]irst name or [l]ast name? '
  sort_order = gets.chomp
  sorted_employees(employees, sort_order).each do |employee|
    print "#{employee.full_name}, #{employee.id}"
    case employee
    when Programmer then puts ", #{employee.languages}"
    when OfficeManager then puts ", #{employee.office}"
    else puts ''
    end
  end
end

def sorted_employees(employees, sort_order)
  if sort_order == 'l'
    employees.sort_by(&:surname)
  elsif sort_order == 'f'
    employees.sort_by(&:full_name)
  else
    puts 'Wrong letter'
    []
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
  gets.chomp.downcase[0]
end

def edit_employees(employees)
  puts '[Edit an employee]'
  print 'ID of the emoloyee you want to edit: '
  id = gets.chomp
  employee = employees.find { |i| i.id == id }
  puts "Current full name: #{employee.full_name}"
  print 'New full name: '
  employee.full_name = gets.chomp
  puts "Current ID: #{employee.id}"
  print 'New ID: '
  employee.id = gets.chomp
  case employee
  when Programmer
    puts "Current languages: #{employee.languages}"
    print 'New Languages: '
    employee.languages = gets.chomp.split(' ')
  when OfficeManager
    puts "Current office: #{employee.office}"
    print 'New Office: '
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
