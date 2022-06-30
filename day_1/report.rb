class Report
  def initialize(measurements)
    @measurements = measurements
  end

  def number_of_depth_measurement_increases
    @measurements.each_with_index.inject(0) do |memo, (current_measurement, index)|
      next memo if index.zero?
      previous_measurement = @measurements[index - 1]

      previous_measurement < current_measurement ? memo += 1 : memo
    end
  end

  def number_of_depth_batch_measurement_increases
    @measurements.each_with_index.inject(0) do |memo, (current_measurement, index)|
      current_measurements = @measurements[index..index + 2]
      next_measurements = @measurements[index + 1..index + 3]
      next memo if next_measurements.count < 3

      current_measurements.sum < next_measurements.sum ? memo += 1 : memo
    end
  end
end
