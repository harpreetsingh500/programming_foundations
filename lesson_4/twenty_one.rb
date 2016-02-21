# Twenty one game program
# 1. Deal two cards to the player.
# 2. Deal two cards to the dealer.
#     :Player can only see the dealers first card.
# 3. Ask the player to 'hit' or 'stay'.
#     :If the player selects 'hit'
#      :Deal another card to the player.
#      :Repeat until player says 'stay' or total value is over 21.
#     :If the player selects 'stay'
#       : Go to step 4.
# 4. See if the total value of the players cards is 21 or greater.
#     :If the value is 21 the player wins.
#     :If the value is greater than 21 the player loses.
# 4. If the dealers total is 21 the dealer wins.
# 6. If the dealers total is less than 17.
#     :Deal another card to the dealer.
#     :Repeat until dealers total is 17 or greater.
# 7. Compare the players total vs dealers total.
# 8. Diplay the winner.
# 9. Ask the player to play again or exit.
require 'pry'
MAX_SCORE = 21
MIN_DEALER_SCORE = 17

def prompt(msg)
  puts "=> #{msg}"
end

def deal_cards!(deck)
  suit = deck.keys.sample
  card = deck[suit].sample
  deck[suit] -= [card]
  return card, suit
end

def deal_cards_player!(deck, player_aces)
  card, suit = deal_cards!(deck)
  player_aces << 1 if card == 'Ace'
  prompt "Player was dealt a #{card} of #{suit}."
  calculate_hand(card)
end

def deal_cards_dealer!(deck, dealer_aces, show = false)
  card, suit = deal_cards!(deck)
  dealer_aces << 1 if card == 'Ace'
  prompt "Dealing a card to the dealer."
  sleep(1)
  prompt "Dealer was dealt a #{card} of #{suit}." if show
  calculate_hand(card)
end

def calculate_hand(card)
  if %w(Jack Queen King).include?(card)
    10
  elsif card == 'Ace'
    11
  else
    card.to_i
  end
end

def change_ace_value(hand_value, aces)
  number_of_aces = aces.size
  if bust?(hand_value)
    number_of_aces.times do
      hand_value -= 10
      aces.pop
      break unless bust?(hand_value)
    end
  end
  hand_value
end

def bust?(hand_value)
  hand_value > MAX_SCORE
end

def hit_or_stay
  ans = ''
  loop do
    prompt "'Hit' or 'Stay'?"
    ans = gets.chomp.downcase
    break if %w(hit stay).include?(ans)
    prompt "Invalid input."
  end
  ans
end

def blackjack?(hand_value)
  hand_value == MAX_SCORE
end

def compare_hands(player, dealer)
  return 'Player' if player > dealer
  return 'Dealer' if dealer > player
end

def play_again?
  prompt "Would you like to play again?"
  ans = gets.chomp.downcase
  ans.start_with?('y')
end

def points_winner(player, dealer)
  return 'Player' if player == 5
  return 'Dealer' if dealer == 5
end

loop do
  player_points = 0
  dealer_points = 0
  prompt "Welcome to twenty-one."
  prompt "First to five points wins!"
  loop do
    sleep(3)
    system 'clear'
    cards = []
    ('1'..'10').each { |num| cards << num }
    cards += ['Jack', 'Queen', 'King', 'Ace']
    deck = { Spades: cards, Diamonds: cards, Hearts: cards, Clubs: cards }
    player_aces = []
    dealer_aces = []
    player_hand_value = 0
    dealer_hand_value = 0
    player_answer = ''

    prompt "Player points: #{player_points}. Dealer points: #{dealer_points}."
    prompt "-----------------------"
    2.times { player_hand_value += deal_cards_player!(deck, player_aces) }
    dealer_hand_value += deal_cards_dealer!(deck, dealer_aces, true)
    dealer_hand_value += deal_cards_dealer!(deck, dealer_aces)

    prompt "-----------------------"
    prompt "Your current total is #{player_hand_value}."
    prompt "You win with Blackjack!" if blackjack?(player_hand_value)
    prompt "-----------------------"
    if blackjack?(player_hand_value)
      player_points += 1
      break if player_points == 5 || dealer_points == 5
      next
    end

    player_answer = hit_or_stay

    if player_answer == 'hit'
      loop do
        player_hand_value += deal_cards_player!(deck, player_aces)
        player_hand_value = change_ace_value(player_hand_value, player_aces)
        break if bust?(player_hand_value)
        prompt "Your current total is #{player_hand_value}."
        break if blackjack?(player_hand_value)
        player_answer = hit_or_stay
        break if player_answer == 'stay'
      end
    end

    prompt "-----------------------"
    prompt "Sorry you busted! Your total is #{player_hand_value}." if bust?(player_hand_value)
    prompt "You win with Blackjack!" if blackjack?(player_hand_value)
    if blackjack?(player_hand_value) || bust?(player_hand_value)
      dealer_points += 1 if bust?(player_hand_value)
      player_points += 1 if blackjack?(player_hand_value)
      break if player_points == 5 || dealer_points == 5
      next
    end

    if player_answer == 'stay'
      loop do
        break if dealer_hand_value >= MIN_DEALER_SCORE
        dealer_hand_value += deal_cards_dealer!(deck, dealer_aces)
        dealer_hand_value = change_ace_value(dealer_hand_value, dealer_aces)
      end
    end

    prompt "-----------------------"
    prompt "Player wins! Dealer busted." if bust?(dealer_hand_value)
    prompt "Dealer wins with Blackjack!" if blackjack?(dealer_hand_value)
    if blackjack?(dealer_hand_value) || bust?(dealer_hand_value)
      player_points += 1 if bust?(dealer_hand_value)
      dealer_points += 1 if blackjack?(dealer_hand_value)
      break if player_points == 5 || dealer_points == 5
      next
    end

    prompt "Player's total is #{player_hand_value}."
    prompt "Dealer's total is #{dealer_hand_value}."

    winner = compare_hands(player_hand_value, dealer_hand_value)
    player_points += 1 if winner == 'Player'
    dealer_points += 1 if winner == 'Dealer'

    prompt winner ? "#{winner} won!" : "It's a tie."
    break if player_points == 5 || dealer_points == 5
    next
  end
  prompt "Player points: #{player_points}. Dealer points: #{dealer_points}."
  prompt "#{points_winner(player_points, dealer_points)} won with five points."
  play_again? ? next : break
end

prompt "Thank you for playing."
