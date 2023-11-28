class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def vertical_to?(another_point)
    self.x == another_point.x
  end

  def horizontal_to?(another_point)
    self.y == another_point.y
  end

  def diagonal_45_degree_to?(another_point)
    (self.x - another_point.x).abs ==
      (self.y - another_point.y).abs
  end
end
