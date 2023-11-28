require_relative 'point'

class Vent
  def initialize(start_params, end_params)
    @start_point = Point.new(*start_params)
    @end_point = Point.new(*end_params)
  end

  def horizontal_and_vertical_points
    if start_point.horizontal_to?(end_point)
      all_horizontal_points
    elsif start_point.vertical_to?(end_point)
      all_vertical_points
    else 
      []
    end
  end

  def all_points
    if start_point.horizontal_to?(end_point)
      all_horizontal_points
    elsif start_point.vertical_to?(end_point)
      all_vertical_points
    elsif diagonal_45_degree?
      all_diagonal_45_degree_points
    else 
      []
    end
  end

  private

  def diagonal_45_degree?
    start_point.diagonal_45_degree_to?(end_point)
  end
  
  def horizontal_or_vertical?
    start_point.horizontal_to?(end_point) ||
      start_point.vertical_to?(end_point)
  end

  def all_horizontal_points
    y = start_point.y
    range_start, range_end = [start_point.x, end_point.x].sort
    (range_start..range_end).to_a.map do |x|
      "#{x},#{y}"
    end
  end

  def all_vertical_points
    x = start_point.x
    range_start, range_end = [start_point.y, end_point.y].sort
    (range_start..range_end).to_a.map do |y|
      "#{x},#{y}"
    end
  end

  def all_diagonal_45_degree_points
    x_diff = end_point.x - start_point.x
    x_sign = x_diff / x_diff.abs # plus or minus

    y_diff = end_point.y - start_point.y
    y_sign = y_diff / y_diff.abs # plus or mnus

    (x_diff.abs + 1).times.with_object([]) do |time, memo|
      x = start_point.x + (time * x_sign)
      y = start_point.y + (time * y_sign)
      memo << "#{x},#{y}"
    end
  end

  attr_reader :start_point, :end_point
end
