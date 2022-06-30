require 'minitest/autorun'
require_relative 'report'

class ReportTest < Minitest::Test
  def test_count_the_number_of_times_a_depth_measurement_increases
    measurements = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert_equal Report.new(measurements).number_of_depth_measurement_increases, 7
  end

  def test_count_the_number_of_times_a_depth_batch_measurement_increases
    measurements = [607, 618, 618, 617, 647, 716, 769, 792]
    assert_equal Report.new(measurements).number_of_depth_batch_measurement_increases, 5
  end
end
