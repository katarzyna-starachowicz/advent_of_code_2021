file_path = 'puzzle_input.txt'
file_data = File.open(file_path).read
great_mothers = file_data.strip.split(',').map(&:to_i)

# pair programming with https://www.phind.com/
# modeling exponential growth (https://math.libretexts.org/Courses/Community_College_of_Denver/MAT_1320_Finite_Mathematics/07%3A_Exponential_and_Logarithmic_Functions/7.01%3A_Exponential_Growth_and_Decay_Models) 

def simulate_lanternfish(days, initial_state)
  lanternfish = Hash.new(0)
  initial_state.each { |fish| lanternfish[fish] += 1 }

  days.times do
    new_lanternfish = lanternfish[0]
    lanternfish[0] = lanternfish[1]
    lanternfish[1] = lanternfish[2]
    lanternfish[2] = lanternfish[3]
    lanternfish[3] = lanternfish[4]
    lanternfish[4] = lanternfish[5]
    lanternfish[5] = lanternfish[6]
    lanternfish[6] = lanternfish[7] + new_lanternfish
    lanternfish[7] = lanternfish[8]
    lanternfish[8] = new_lanternfish
  end

  lanternfish.values.sum
end

p simulate_lanternfish(256, great_mothers)
