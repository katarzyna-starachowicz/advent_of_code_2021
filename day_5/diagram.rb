require_relative 'vent'

class Diagram
  def initialize(file_path)
    @points = Hash.new(0)

    fulfill_points!(file_path, :all_points)
  end

  def dangerous_points_number
    @points&.count { |_, crossing_vents_number| crossing_vents_number >= 2 }
  end

  private

  def fulfill_points!(file_path, points)
    File.open(file_path).readlines.map do |line|
      vent = Vent.new(*extract_coordinates_from(line))
      vent.send(points).each do |point|
        @points[point] += 1
      end
    end
  end

  def extract_coordinates_from(line)
    line.chomp.split(' -> ').map { |coordinates| coordinates.split(',') }
  end
end
