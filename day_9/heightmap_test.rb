require 'minitest/autorun'
require 'minitest/spec'

require_relative 'heightmap'

describe Heightmap do
  it 'sums risk levels' do
    expect(Heightmap.new('test_input.txt').sum_of_risk_levels).must_equal(15)
    expect(Heightmap.new('puzzle_input.txt').sum_of_risk_levels).must_equal(564)
  end

  it 'can multiply sizes of three largest basins' do
    expect(Heightmap.new('test_input.txt').multiplied_sizes_of_three_largest_basins)
      .must_equal(1_134)

    expect(Heightmap.new('puzzle_input.txt').multiplied_sizes_of_three_largest_basins)
      .must_equal(1_038_240)
  end
end
