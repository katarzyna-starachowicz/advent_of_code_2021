class Point
  attr_reader :height

  def initialize(height, column_index, row_index)
    @height = height
    @column_index = column_index
    @row_index = row_index
  end

  def up_point_location
    @up ||= Location.new(column_index, positive_index(row_index - 1))
  end

  def down_point_location
    @down ||= Location.new(column_index, row_index + 1)
  end

  def right_point_location
    @right ||= Location.new(column_index + 1, row_index)
  end
  
  def left_point_location
    @left ||= Location.new(positive_index(column_index - 1), row_index)
  end

  def location_code
    @location_code ||= "#{column_index}_#{row_index}"
  end

  private

  def positive_index(index)
    (index.zero? || index.positive?) ? index : 1000_000_000_000
  end

  Location = Struct.new(:column_index, :row_index)

  attr_reader :column_index, :row_index
end
