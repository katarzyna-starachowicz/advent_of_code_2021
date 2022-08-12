class Report
  def initialize(measurements)
    @measurements = measurements
  end

  def number_of_depth_measurement_increases
    @measurements.each_cons(2).inject(0) do |memo, (first_measurement, second_measurement)|
      first_measurement < second_measurement ? memo += 1 : memo
    end
  end

  def number_of_depth_batch_measurement_increases
    @measurements.each_cons(3).each_cons(2).inject(0) do |memo, (first_measurement_batch, second_measurement_batch)|
      first_measurement_batch.sum < second_measurement_batch.sum ? memo += 1 : memo
    end
  end
end
