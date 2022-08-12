require_relative 'submarine_power_consumption_calculator'

file = File.open('puzzle_input.txt')
diagnostic_report = file.readlines.map(&:chomp)

calculator = SubmarinePowerConsumptionCalculator.new(diagnostic_report)

p 'Answer to puzzle 1:'
p calculator.calculate
