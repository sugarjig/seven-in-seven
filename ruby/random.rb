random_num = rand(10) + 1
puts 'Guess a number between 1 and 10 (inclusive)'
user_input = gets
loop do
  if user_input.to_i > random_num
    puts 'Your guess is too high'
  elsif user_input.to_i < random_num
    puts 'Your guess is too low'
  else
    puts 'Correct!'
    break
  end
  user_input = gets
end
