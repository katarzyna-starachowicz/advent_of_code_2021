require_relative './lib/bingo_first_win'
require_relative './lib/bingo_last_win'

file = File.open('./lib/puzzle_input.txt')
p "Fist puzzle answer is #{BingoFirstWin.new(file).final_score}"

file = File.open('./lib/puzzle_input.txt')
p "Second puzzle answer is #{BingoLastWin.new(file).final_score}"
