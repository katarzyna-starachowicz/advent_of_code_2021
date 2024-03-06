require_relative 'point'
require_relative 'queue'

class Heightmap
  def initialize(file_name)
    @map = []
    prepare_map!(file_name)
  end

  def sum_of_risk_levels 
    @sorl ||= all_low_points.inject(0) { |sum, point| sum += point.height + 1 }
  end

  def multiplied_sizes_of_three_largest_basins
    @msoftlb ||= three_largest_basin_sizes.inject(:*) 
  end

  private

  def three_largest_basin_sizes
    all_basin_sizes.max(3)
  end

  def all_basin_sizes
    all_low_points.map do |low_point|
      calculate_basin_size(low_point)
    end
  end

  def calculate_basin_size(low_point)
    queue = Queue.new
    queue.enqueue(low_point)
    enqueued = { low_point.location_code => true }

    while current_point = queue.dequeue do
      adjacent_points(current_point).each do |neighbour|
        # Locations of height 9 do not count as being in any basin
        next if neighbour.height == 9 || enqueued[neighbour.location_code]

        if neighbour.height > current_point.height
          queue.enqueue(neighbour)
          enqueued[neighbour.location_code] = true 
        end
      end
    end

    enqueued.size
  end

  def all_low_points
    return @all_low_points if defined?(@all_low_points)

    @all_low_points = map.each_with_object([]) do |row, points|
      row.each do |point|
        points.push(point) if low_point?(point)
      end
    end
  end

  def low_point?(point)
    adjacent_points(point).all? { |neighbour| point.height < neighbour.height }
  end

  def adjacent_points(point)
    [
      find_point(point.up_point_location),
      find_point(point.down_point_location),
      find_point(point.right_point_location),
      find_point(point.left_point_location)
    ].compact
  end

  def find_point(location)
    map.fetch(location.column_index, []).fetch(location.row_index, nil)
  end

  def prepare_map!(file_name)
    column_index = 0

    IO.foreach(file_name) do |line|
      row = []
      line.strip.split('').each_with_index do |height_of_location, row_index|
        row << Point.new(height_of_location.to_i, column_index, row_index)
      end

      @map[column_index] = row

      column_index += 1
    end
  end

  attr_reader :map
end
