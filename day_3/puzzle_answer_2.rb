require_relative 'submarine_life_support_rating_calculator'

file = File.open('puzzle_input.txt')
diagnostic_report = file.readlines.map(&:chomp)

calculator = SubmarineLifeSupportRatingCalculator.new(diagnostic_report)

p 'Answer to puzzle 2:'
p calculator.calculate
