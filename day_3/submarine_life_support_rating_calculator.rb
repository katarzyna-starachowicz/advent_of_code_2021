class DiagnosticReport
  class << self
    def select_number_by_most_common_value(report)
      select_number(report, bit_criteria: :max_by)
    end
      
    def select_number_by_least_common_value(report)
      select_number(report, bit_criteria: :min_by)
    end
    
    private
    
    def select_number(report, bit_criteria:, bit_position: 0)
      selected_numbers = select_numbers(report, bit_criteria: bit_criteria, bit_position: bit_position)
      return selected_numbers.first if selected_numbers.count == 1

      select_number(selected_numbers, bit_criteria: bit_criteria, bit_position: bit_position + 1)
    end

    def select_numbers(report, bit_criteria:, bit_position:)
      bits_occurance_report(report, bit_position)
        .send(bit_criteria) { |bit, binary_numbers| [binary_numbers.count, bit] }
        .last
    end
  
    def bits_occurance_report(report, bit_position)
      ones, zeros = report.partition { |binary_number| binary_number[bit_position].eql?('1') }
      { '0' => zeros, '1' => ones }
    end
  end
end

class SubmarineLifeSupportRatingCalculator
  attr_reader :diagnostic_report

  def initialize(diagnostic_report)
    @diagnostic_report = diagnostic_report
  end

  def calculate
    oxygen_generator_rating * co2_scrubber_rating    
  end

  private

  def oxygen_generator_rating
    DiagnosticReport
      .select_number_by_most_common_value(diagnostic_report)
      .to_i(2)
  end

  def co2_scrubber_rating
    DiagnosticReport
      .select_number_by_least_common_value(diagnostic_report)
      .to_i(2)
  end
end

