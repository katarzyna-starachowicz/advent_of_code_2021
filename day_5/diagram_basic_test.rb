require_relative 'diagram_basic'

require 'minitest/autorun'
require 'minitest/spec'

describe DiagramBasic do
  it 'finds how many points do at least two lines overlap' do
    file_path = 'puzzle_test_input.txt'
    diagram = DiagramBasic.new(file_path)

    assert_equal 5, diagram.dangerous_points_number
  end
end
