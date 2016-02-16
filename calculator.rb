# This is a calculator program.
# Ask the user for two numbers.
# Ask the user for the operation to perform on the numbers.
# Dispaly the result after performing the operation.
require 'yaml'
MESSAGES = YAML.load_file("calculator_messages.yml")
def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  if num.include?(".")
    num.insert(0, "0") if (num[0] == ".") 
    (num == num.to_f.to_s) ? num.to_f : false
  else
    (num == num.to_i.to_s) ? num.to_i : false
  end
end

def operator_prompt(op)
  result = case op
           when '1' then "Adding"
           when '2' then "Subtracting"
           when '3' then "Multiplying"
           when '4' then "Dividing"
           end
  result           
end

prompt(MESSAGES["welcome"])
prompt(MESSAGES["name"])
name = ''

loop do
  name = Kernel.gets().chomp()
  name.empty?() ? prompt(MESSAGES["valid_name"]) : break
end

prompt(MESSAGES["say_hello"])

loop do
  prompt(MESSAGES["first_number"])
  number1 = ''

  loop do
    number1 = Kernel.gets().chomp()
    break if number1 = valid_number?(number1)
    prompt(MESSAGES["valid_number"])
  end

  prompt(MESSAGES["second_number"])
  number2 = ''

  loop do
    number2 = Kernel.gets().chomp()
    break if number2 = valid_number?(number2)
    prompt(MESSAGES["valid_number"])
  end
  
  operator = <<-MSG
    What operation would you like to perform?
    1. Add
    2. Subtract
    3. Multiply
    4. Divide
  MSG
  prompt(operator)
  operation = ''

  loop do
    operation = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operation)
    prompt(MESSAGES["valid_operator"])
  end

  prompt("#{operator_prompt(operation)} the two numbers.")

  result = case operation
           when '1' then number1 + number2
           when '2' then number1 - number2
           when '3' then number1 * number2
           when '4' then number1.to_f() / number2.to_f()
           end

  prompt("The result is #{result}.")

  prompt(MESSAGES["try_again"])
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end
