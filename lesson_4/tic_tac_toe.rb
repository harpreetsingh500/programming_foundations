# Tic Tac Toe Program
# 1. Display Empty board
# 2. Ask the user to input a value in the board.(X)
# 3. Assign a value for the computer in the board.(O)
# 4. Check if the user or the computer won.
# 5. If either won display the winner.
# 7. If board is not full and their is no winner. Go back to step 2.
# 8. If board is full and their is no winner display than its a tie.
# 9. Ask user to play again. If 'yes' go to step 1. If 'no' stop the program.
require 'pry'
INITIAL_VALUE = ' '.freeze
PLAYER_VALUE = 'X'.freeze
COMPUTER_VALUE = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                 [1, 4, 7], [2, 5, 8], [3, 6, 9], # columns
                 [1, 5, 9], [3, 5, 7]].freeze # diagonals
FIRST_MOVE = 'choose'.freeze

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system 'clear'
  prompt "Player piece #{PLAYER_VALUE}. Computer piece #{COMPUTER_VALUE}."
  puts " #{brd[1]} | #{brd[2]} | #{brd[3]} "
  puts "---+---+---"
  puts " #{brd[4]} | #{brd[5]} | #{brd[6]} "
  puts "---+---+---"
  puts " #{brd[7]} | #{brd[8]} | #{brd[9]} "
end

def initialize_board(board)
  (1..9).each { |num| board[num] = INITIAL_VALUE }
end

def empty_squares(brd)
  brd.keys.select { |key| brd[key] == INITIAL_VALUE }
end

def joinor(brd)
  return empty_squares(brd).join if empty_squares(brd).size == 1
  empty_squares(brd).join(", ").insert(-2, "or ")
end

def player_picks_piece(brd)
  player_choice = ''
  loop do
    prompt "Choose square #{joinor(brd)}."
    player_choice = gets.chomp.to_i
    break if empty_squares(brd).include?(player_choice)
    prompt "Invalid Input"
  end
  brd[player_choice] = PLAYER_VALUE
end

def computer_picks_piece(brd)
  square = computer_offense(brd)
  return brd[square] = COMPUTER_VALUE if square
  square = computer_defense(brd)
  return brd[square] = COMPUTER_VALUE if square
  return brd[5] = COMPUTER_VALUE if empty_squares(brd).include?(5)
  computer_choice = empty_squares(brd).sample
  brd[computer_choice] = COMPUTER_VALUE
end

def computer_offense(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_VALUE) == 2 && brd.values_at(*line).count(PLAYER_VALUE) == 0
      return brd.select { |k, v| line.include?(k) && v == INITIAL_VALUE }.keys.first
    end
  end
  nil
end

def computer_defense(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_VALUE) == 2 && brd.values_at(*line).count(COMPUTER_VALUE) == 0
      return brd.select { |k, v| line.include?(k) && v == INITIAL_VALUE }.keys.first
    end
  end
  nil
end

def anyone_win?(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_VALUE) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_VALUE) == 3
      return 'Computer'
    end
  end
  nil
end

def board_full?(brd)
  return true if empty_squares(brd) == []
  false
end

def play_again?(answer)
  return false if answer.start_with?('y')
  true
end

def point_winner(player1, player2)
  return 'Player' if player1 == 5
  return 'Computer' if player2 == 5
end

def place_piece!(brd, player)
  computer_picks_piece(brd) if player == 'Computer'
  player_picks_piece(brd) if player == 'Human'
end

def alternate_player(player)
  return 'Human' if player == 'Computer'
  return 'Computer' if player == 'Human'
end

board = {}
loop do
  prompt "First player to 5 points wins."
  player_points = 0
  computer_points = 0
  current_player = 'Human'

  loop do
    initialize_board(board)

    if FIRST_MOVE == 'choose'
      prompt "Let the computer go first? (yes or no)"
      ans = gets.chomp
    end

    if ans.start_with?('y')
      current_player = 'Computer'
      loop do
        place_piece!(board, current_player)
        display_board(board)
        current_player = alternate_player(current_player)
        break if anyone_win?(board) || board_full?(board)
      end
    else
      loop do
        display_board(board)
        place_piece!(board, current_player)
        current_player = alternate_player(current_player)
        break if anyone_win?(board) || board_full?(board)
      end
    end

    display_board(board)
    if anyone_win?(board)
      prompt "#{anyone_win?(board)} won!"
      player_points += 1 if anyone_win?(board) == 'Player'
      computer_points += 1 if anyone_win?(board) == 'Computer'
    else
      prompt 'Its a tie.'
    end

    prompt "Current score: Player #{player_points}. Computer points #{computer_points}."
    break if player_points == 5 || computer_points == 5
    sleep(3)
  end

  prompt "#{point_winner(player_points, computer_points)} won with 5 points!"
  prompt "Would you like to play again? (yes or no)"
  answer = gets.chomp
  break if play_again?(answer)
end
