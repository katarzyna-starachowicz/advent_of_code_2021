class DiagnosticReport
  attr_reader :report

  def initialize(raw_report)
    @report = structurize_report(raw_report)
  end

  def gamma_rate
    report.map do |_bit_postion, bits_report|
      bits_report.max_by { |_bit, bit_occurance| bit_occurance }.first
    end.join
  end

  def epsilon_rate
    report.map do |_bit_postion, bits_report|
      bits_report.min_by { |_bit, bit_occurance| bit_occurance }.first
    end.join
  end
  
  private
  
  def structurize_report(raw_report)
    bits_number = raw_report.first.length

    (0...bits_number).inject({}) do |hash_report, bit_position|
      hash_report.merge(
        bit_position => bits_occurance_report(raw_report, bit_position)
      )
    end
  end

  def bits_occurance_report(raw_report, bit_position)
    initial_hash = { '0' => 0, '1' => 0 }
    raw_report.inject(initial_hash) do |hash_bits_report, bits|
      bit = bits[bit_position]
      bit_occurance = hash_bits_report[bit] + 1

      hash_bits_report.merge(bit => bit_occurance)
    end
  end
end

class SubmarinePowerConsumptionCalculator
  attr_reader :diagnostic_report

  def initialize(diagnostic_report)
    @diagnostic_report = DiagnosticReport.new(diagnostic_report)
  end

  def calculate
    gamma_rate * epsilon_rate    
  end

  private

  def gamma_rate
    diagnostic_report.gamma_rate.to_i(2)
  end

  def epsilon_rate
    diagnostic_report.epsilon_rate.to_i(2)
  end
end

