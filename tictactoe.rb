require 'pry'

WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

def initialize_board
  board = {}
  (1..9).each { |square| board[square] = " " }
  board
end

def draw_board(board)
  system "clear"
  puts " #{board[1]} | #{board[2]} | #{board[3]} "
  puts "-----------"
  puts " #{board[4]} | #{board[5]} | #{board[6]} "
  puts "-----------"
  puts " #{board[7]} | #{board[8]} | #{board[9]} "
end

def empty_squares(board)
  board.select { |k, v| v == " " }.keys
end

def player_chooses_square(board)
  begin
    puts "What's your move? (1-9):"
    square = gets.chomp.to_i
  end until empty_squares(board).include?(square)
  board[square] = "X"
end

def computer_wins(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count("O") == 2
      line.each do |square|
        if board[square] == " "
          board[square] = "O"
        end
      end
    end
  end
  nil
end

def computer_blocks(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count("X") == 2
      line.each do |square|
        if board[square] == " "
          board[square] = "O"
        end
      end
    end
  end
  false
end

def computer_chooses_square(board)
  if computer_wins(board)
  elsif computer_blocks(board)
  else
    square = empty_squares(board).sample
    board[square] = "O"
  end
end

def check_winner(board)
  WINNING_LINES.each do |line|
    return "Player" if board.values_at(*line).count("X") == 3
    return "Computer" if board.values_at(*line).count("O") == 3
  end
  nil
end

board = initialize_board
draw_board(board)

begin
  player_chooses_square(board)
  computer_chooses_square(board)
  draw_board(board)
  winner = check_winner(board)
end until winner || empty_squares(board).empty?

if winner
  puts "#{winner} won!"
else
  puts "It's a tie!"
end
