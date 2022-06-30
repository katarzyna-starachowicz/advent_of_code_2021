class Submarine
  def initialize
    @horizontal_position = 0
    @depth = 0
  end
  
  def forward units 
    @horizontal_position += units
  end

  def up units 
    @depth += units
  end

  def down units 
    @depth -= units
  end

  def final_position
    (@horizontal_position * @depth).abs
  end
end
