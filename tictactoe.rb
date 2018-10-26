board = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

def print_board(board)
  3.times do |i|
    3.times do |j|
      print " [ #{board[i][j]} ]"
    end
    puts ""
  end
end

puts "Welcome to the Tic Tac Toe game"
player = 'O'

loop do
  print_board(board)
  puts "Player '#{player}' move"
  print "Where do you want to put a '#{player}' [0-8]? "
  field = gets.to_i

  if field > 8 || field < 0
    puts "Invalid field! Try again."
    next
  end

  i = field / 3
  j = field % 3
  puts "#{i}, #{j}, #{board[i][j]}"
  if board[i][j] == 'X' || board[i][j] == 'O'
    puts "That field is already occupied! Try again."
    next
  else
    puts "Set #{player} to field #{field}"
    board[i][j] = player
  end
  if player == 'O'
    player = 'X'
  else
    player = 'O'
  end
end
