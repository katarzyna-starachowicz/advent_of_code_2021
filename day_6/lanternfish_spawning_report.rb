require 'minitest/autorun'
require 'minitest/spec'

# Inefficient way, but modelled in a nice way :)
class Lanternfish
  def initialize(timer: 8)
    @timer = timer
    @just_spawned = true
  end

  def carpe_diem
    next_day!

    spawn_fish 
  end

  private

  def next_day!
    if @timer.zero?
      @just_spawned = false
      @timer = 6
    else
      @timer -= 1
    end
  end

  def timer_just_reset?
    @timer == 6 && !@just_spawned
  end

  def spawn_fish
    Lanternfish.new if timer_just_reset?
  end
end

class School
  def initialize(great_mothers:)
    @fish = great_mothers.map { |timer| Lanternfish.new(timer: timer) }
    @fish_count = @fish.count
  end
  
  def carpe_diem
    new_fish = []

    @fish.each do |fish|
      new_fish << fish.carpe_diem
    end

    new_fish.compact!
    @fish_count += new_fish.count

    @fish.concat(new_fish.compact)
  end

  def total_lanternfish
    @fish_count
  end
end

class LanternfishSpawningReport
  def initialize(great_mothers:)
    @school = School.new(great_mothers: great_mothers)
  end

  def model_lantern_fish(after_days:)
    after_days.times { @school.carpe_diem }
    
    @school.total_lanternfish
  end
end

describe LanternfishSpawningReport do
  def setup
    @great_mothers = [3, 4, 3, 1, 2]
  end

  it 'models lanternfish after 18 days' do
    report = LanternfishSpawningReport.new(great_mothers: @great_mothers)

    assert_equal 26, report.model_lantern_fish(after_days: 18)
  end

  it 'models lanternfish after 80 days' do
    report = LanternfishSpawningReport.new(great_mothers: @great_mothers)

    assert_equal 5934, report.model_lantern_fish(after_days: 80)
  end
end
