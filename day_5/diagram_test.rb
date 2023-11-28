require_relative 'diagram'

require 'minitest/autorun'
require 'minitest/spec'

describe Diagram do
  it 'finds how many points do at least two lines overlap' do
    file_path = 'puzzle_test_input.txt'
    diagram = Diagram.new(file_path)

    assert_equal 12, diagram.dangerous_points_number
  end
end
