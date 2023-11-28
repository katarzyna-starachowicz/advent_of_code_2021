require_relative 'diagram'

# This diagram version handles only horizontal and vertical vents,
# skips the rest.
class DiagramBasic < Diagram
  def initialize(file_path)
    @points = Hash.new(0)

    fulfill_points!(file_path, :horizontal_and_vertical_points)
  end
end
