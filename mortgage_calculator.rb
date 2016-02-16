# This program will calculate the monthly interest rate.
# Get the loan amount from the user.
# Get the Annual Percentage Rate(APR) from the user.
# Get the laon duration in years from the user.
# Calculate the monthly interest rate and print to the screen.
# Calculate the loan duration in months

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  if num.include?(".")
    num.insert(0, "0") if num[0] == "."
    (num == num.to_f.to_s) ? num.to_f : false
  else
    (num == num.to_i.to_s) ? num.to_i : false
  end
end

prompt("Welcome to the mortgage calculator.")

loop do
  prompt("Enter the loan amount: ")
  loan_amount = ''

  loop do
    loan_amount = Kernel.gets().chomp()
    break if loan_amount = valid_number?(loan_amount)
    prompt("Enter a valid number.")
  end

  prompt("Enter the Annual Percentage Rate(APR).")
  apr = ''

  loop do
    apr = Kernel.gets().chomp()
    break if apr = valid_number?(apr)
    prompt("Enter a valid number.")
  end

  prompt("Enter the Loan duration in years.")
  loan_duration = ''

  loop do
    loan_duration = Kernel.gets().chomp()
    break if loan_duration = valid_number?(loan_duration)
    prompt("Enter a valid number.")
  end

  annual_interest_rate = apr.to_f / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = loan_duration * 12

  monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**-months.to_i()))

  prompt("Your monthly payment is $#{format('%02.2f', monthly_payment)}")

  prompt("Type 'Yes' to try again")
  answer = Kernel.gets().chomp()
  break unless answer.downcase == 'yes'
end
