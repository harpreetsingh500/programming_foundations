# Rock paper and scissors program.
# Ask the user to pick rock, paper or scissors.
# Give the computer either rock, paper or scissors(chosen randomly).
# Compare the values between the user and the computer.
# Display what they picked and then who won.
# Ask the user if they want to play again.

choice_hash = { 'r' => 'rock', 'p' => 'paper', 's' => 'scissors',
                'l' => 'lizard', 'sp' => 'spock' }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def who_won?(first, second)
  (first == 'r' && (second == 's' || second == 'l')) ||
    (first == 'p' && (second == 'r' || second == 'sp')) ||
    (first == 's' && (second == 'p' || second == 'l')) ||
    (first == 'sp' && (second == 'r' || second == 's')) ||
    (first == 'l' && (second == 'p' || second == 'sp'))
end

def result(player, computer)
  if who_won?(player, computer)
    "Player wins!"
  elsif who_won?(computer, player)
    "Computer wins!"
  else
    "It's a tie."
  end
end

def five_point_winner(player)
  if player == 5
    prompt("Player won with 5 points.")
  else
    prompt("Computer won with 5 points.")
  end
end

loop do
  player_points = 0
  computer_points = 0

  prompt("First to five points wins!\n\n")

  loop do
    choice_hash.each { |key, value| prompt("Type #{key} for #{value}") }
    player_choice = ''

    loop do
      player_choice = Kernel.gets().chomp().downcase()
      break if choice_hash.include?(player_choice)
      prompt("Enter a valid choice.")
    end

    computer_value = choice_hash.keys.sample

    prompt("Player has #{choice_hash[player_choice]}. Computer has #{choice_hash[computer_value]}.")

    winner = result(player_choice, computer_value)
    prompt(winner + "\n\n")

    if winner.start_with?('P')
      player_points += 1
    elsif winner.start_with?('C')
      computer_points += 1
    end

    prompt("Player has #{player_points} points.")
    prompt("Computer has #{computer_points} points.\n\n")

    break if (player_points == 5) || (computer_points == 5)
  end

  five_point_winner(player_points)

  prompt("Type 'Yes' to play again.")
  play_again = Kernel.gets().chomp().downcase()
  break unless play_again == 'yes'
end
