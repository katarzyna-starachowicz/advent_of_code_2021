require 'minitest/autorun'
require 'minitest/spec'

require_relative 'submarine_life_support_rating_calculator'

describe SubmarineLifeSupportRatingCalculator do
  it 'calculates life support rating' do
    diagnostic_report = [
      '00100',
      '11110',
      '10110',
      '10111',
      '10101',
      '01111',
      '00111',
      '11100',
      '10000',
      '11001',
      '00010',
      '01010'
    ]
    calculator = SubmarineLifeSupportRatingCalculator.new(diagnostic_report)

    assert_equal 230, calculator.calculate
  end
end
