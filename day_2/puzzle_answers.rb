require_relative 'submarine'
require_relative 'submarine_with_manual'

file = File.open('puzzle_input.txt')

submarine = Submarine.new

file.readlines.each do |line|
  method_name, units = line.chomp.split
  submarine.send(method_name, units.to_i)
end

p 'Answer to puzzle 1:'
p submarine.final_position


file = File.open('puzzle_input.txt')
submarine = SubmarineWithManual.new

file.readlines.each do |line|
  method_name, units = line.chomp.split
  submarine.send(method_name, units.to_i)
end

p 'Answer to puzzle 2:'
p submarine.final_position
