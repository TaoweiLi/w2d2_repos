require "employee"

class Startup
  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name  #string
    @funding = funding  #number
    @salaries = salaries  #hash
    @employees = []
  end

  def valid_title?(title)
    @salaries.key?(title)
  end

  def >(other_startup)
    self.funding > other_startup.funding
  end

  def hire(employee_name, title)
    if !@salaries.key?(title)
      raise Error.new
    else
      employee_ins = Employee.new(employee_name, title)
      @employees << employee_ins
    end
  end

  def size
    @employees.length
  end

  def pay_employee(employee)
    if @funding >= @salaries[employee.title]
      employee.pay(@salaries[employee.title])
      @funding -= @salaries[employee.title]
    else
      raise Error.new
    end
  end

  def payday
    @employees.each do |ele|
      self.pay_employee(ele)
    end
  end

  #part3
  def average_salary
    salaries_total = 0

    @employees.each do |employee|
      salaries_total += @salaries[employee.title]
    end

    return avg = salaries_total / @employees.length
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(another_startup)
    @funding += another_startup.funding

    another_startup.salaries.each do |title, salary|
      if !@salaries.key?(title)
        @salaries[title] = salary
      end
    end

    @employees.push(*another_startup.employees)
    another_startup.close
  end
end
