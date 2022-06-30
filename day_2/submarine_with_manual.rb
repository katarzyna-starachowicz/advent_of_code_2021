class SubmarineWithManual
  def initialize
    @aim = 0
    @horizontal_position = 0
    @depth = 0
  end
  
  def forward units 
    @horizontal_position += units
    @depth += @aim * units
  end

  def up units 
    @aim -= units
  end

  def down units 
    @aim += units
  end

  def final_position
    (@horizontal_position * @depth).abs
  end
end
