# file_name = 'test_input.txt'
file_name = 'puzzle_input.txt'

raw_heightmap = []
IO.foreach(file_name) do |line|
  raw_heightmap.push(
    line.strip.split('').map(&:to_i)
  )
end

class Heightmap
  def initialize(map)
    @map = map
  end

  def each_height
    map.each_with_index do |row, column_index|
      row.each_with_index do |height_of_location, row_index|
        yield height_of_location, column_index, row_index
      end
    end
  end

  def adjacent_locations(column_index, row_index)
    up_location = map.fetch(column_index, []).fetch(positive_index(row_index - 1), nil)
    down_location = map.fetch(column_index, []).fetch(row_index + 1, nil)
    right_location = map.fetch(column_index + 1, []).fetch(row_index, nil)
    left_location = map.fetch(positive_index(column_index - 1), []).fetch(row_index, nil)

    [up_location, down_location, right_location, left_location].compact
  end

  private

  def positive_index(index)
    (index.zero? || index.positive?) ? index : 1000_000_000_000
  end

  attr_reader :map
end

def low_point?(height, adjacent_locations)
  adjacent_locations.all? { |location| height < location }
end

heightmap = Heightmap.new(raw_heightmap)
sum_of_risk_levels = 0
heightmap.each_height do |height, column_index, row_index|
  if low_point?(height, heightmap.adjacent_locations(column_index, row_index))
    sum_of_risk_levels += (height + 1)
  end
end

p sum_of_risk_levels


