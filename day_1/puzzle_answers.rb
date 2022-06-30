require_relative 'report'

file = File.open('puzzle_input.txt')
measurements = file.readlines.map(&:to_i)

report = Report.new(measurements)

p 'Answer for puzzle 1:'
p report.number_of_depth_measurement_increases

p 'Answer for puzzle 2:'
p report.number_of_depth_batch_measurement_increases
