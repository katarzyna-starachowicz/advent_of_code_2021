require 'minitest/autorun'
require 'minitest/spec'

require_relative 'linter'

describe Linter do
  it 'calculates total syntax error score' do
    expect(Linter.new('test_input.txt').total_syntax_error_score)
      .must_equal(26_397)

    expect(Linter.new('input.txt').total_syntax_error_score)
      .must_equal(469_755)
  end

  it 'finds middle completion score' do
    expect(Linter.new('test_input.txt').middle_completion_score)
      .must_equal(288_957)

    expect(Linter.new('input.txt').middle_completion_score)
      .must_equal(2_762_335_572)
  end
end
