require 'minitest/autorun'
require 'minitest/spec'

require_relative 'submarine_power_consumption_calculator'

describe SubmarinePowerConsumptionCalculator do
  it 'calculates power consumption' do
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
    calculator = SubmarinePowerConsumptionCalculator.new(diagnostic_report)

    assert_equal 198, calculator.calculate
  end
end
