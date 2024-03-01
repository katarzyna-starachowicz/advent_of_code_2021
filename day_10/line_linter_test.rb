require 'minitest/autorun'
require 'minitest/spec'

require_relative 'line_linter'

describe LineLinter do
  it 'validates line' do
    expect(LineLinter.new('<]').valid?).must_be_same_as false
    expect(LineLinter.new('<>').valid?).must_be_same_as true
    expect(LineLinter.new('<{').valid?).must_be_same_as true
  end

  it 'calculates syntax error score for an illegal )' do
    expect(LineLinter.new('[<(<(<(<{}))><([]([]()').syntax_error_score).must_equal 3
  end

  it 'calculates syntax error score for an illegal ]' do
    expect(LineLinter.new('[{[{({}]{}}([{[{{{}}([]').syntax_error_score).must_equal 57
  end

  it 'calculates syntax error score for an illegal }' do
    expect(LineLinter.new('{([(<{}[<>[]}>{[]{[(<()>').syntax_error_score).must_equal 1_197
  end

  it 'calculates syntax error score for an illegal >' do
    expect(LineLinter.new('<{([([[(<>()){}]>(<<{{').syntax_error_score).must_equal 25_137
  end

  it 'raises an error when asked for erorr score of valid line' do
    expect  { LineLinter.new('<[]>').syntax_error_score }
      .must_raise('Syntax error score cannot be calculated for valid syntax')
  end

  it 'calculates completion score' do
    expect(LineLinter.new('<{([{{}}[<[[[<>{}]]]>[]]').completion_score).must_equal 294
  end

  it 'raises an error when asked for completion score of invalid line' do
    expect { LineLinter.new('<[>>').completion_score }
      .must_raise('Invalid syntax cannot be completed')
  end
end
