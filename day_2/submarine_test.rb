require 'minitest/autorun'
require_relative 'submarine'
require_relative 'submarine_with_manual'

class SubmarineTest < Minitest::Test
  def test_calculate_final_position
    submarine = Submarine.new
    submarine.forward 5
    submarine.down 5
    submarine.forward 8
    submarine.up 3
    submarine.down 8
    submarine.forward 2

    assert_equal submarine.final_position, 150
  end
end

class SubmarineWithManualTest < Minitest::Test
  def test_calculate_final_position
    submarine = SubmarineWithManual.new
    submarine.forward 5
    submarine.down 5
    submarine.forward 8
    submarine.up 3
    submarine.down 8
    submarine.forward 2

    assert_equal submarine.final_position, 900
  end
end
