def calculate_total(cards)
   # [['H', '3'], ['S', 'Q'], ... ]
  arr = cards.map{ |e| e[1] }

  total = 0
  arr.each do |value|
    if value == 'A' # Aces
      total += 11
    elsif value.to_i == 0 #Jack, Queen or Kings
      total = total + 10 #same as += 10
    else
      total += value.to_i # All other cards
    end
  end

  # Correct for Aces
  arr.select{|e| e == 'A'}.count.times do
    if total > 21
      total -= 10
    end
  end

  total
end


def say(message)
  puts message
end


def deal_new_card(card)
  card << deck.pop
end

# Start game
say("Welcome to Blackjack!")

suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

deck = suits.product(cards)
deck.shuffle!

# Deal Cards

mycards = []
dealercards = []

2.times do
  mycards << deck.pop
  dealercards << deck.pop
end

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

# Show Cards

say("........Shuffling cards.......")
3.times do
  print ".........."
  sleep 0.5
end

puts ""
say("Dealer has: #{dealercards[0]} and *")
say("You have: #{mycards[0]} and #{mycards[1]} for a total of: #{mytotal}")
puts ""

# Player turn
if mytotal == 21
  say("Congratulations. You hit Blackjack. You win!")
  exit
end

while mytotal < 21
  say("What would you like to do? 1) hit 2) stay")
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    say("Error: You have to either enter 1 (hit) or 2 (stay)")
    next
  end
  
  if hit_or_stay == '2'
    say("You chose to stay")
    break
  end

  # Hit
  new_card = deck.pop
  say("Dealing new card to player #{new_card}")
  mycards << new_card
  mytotal = calculate_total(mycards)
  say("Your total is now: #{mytotal}")

  if mytotal == 21
    say("Congratulations, you hit blackjack! You win!")
    exit
  elsif mytotal > 21
    say("Sorry, it looks like you busted!")
    exit
  end
end

# Dealer turn

if dealertotal == 21
  say("Sorry, dealer hit blackjack! You lose!")
  exit
end

while dealertotal < 17
  # Hit
  new_card = deck.pop
  say("Dealing new card for dealer: #{new_card}")
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  say("Dealertotal is now #{dealertotal}")

  if dealertotal == 21
    say("Sorry, dealer hit blackjack. You lose!")
    exit
  elsif dealertotal > 21
    say("Congratulations, dealer busted! You win!")
    exit
  end

end

# Compare hands

say("Dealer's cards:")
dealercards.each { |card| puts "=> #{card}" }
puts ""
say("Your cards:")
mycards.each { |card| puts "=> #{card}" }
puts ""

if dealertotal > mytotal
  say("Sorry, dealer won.")
elsif dealertotal < mytotal
  say("Congratulations, you win!")
else
  say("It's a tie!")

end

exit