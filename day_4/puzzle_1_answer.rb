require_relative './lib/bingo'

file = File.open('./lib/puzzle_1_input.txt')
p Bingo.new(file).final_score
