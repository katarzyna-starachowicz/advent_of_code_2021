file = 'test_input.txt'
file = 'input.txt'

class Stack
  def initialize
    @array = []
  end

  def push(element)
    array.push(element)
  end

  def pop
    array.pop
  end

  private

  attr_accessor :array
end

class SyntaxTool
  CHUNK_PAIRS = {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
  }.freeze

  def initialize(file)
    @file = file
  end

  def open_char?(char)
    CHUNK_PAIRS.keys.include?(char)
  end

  def invalid_chunk?(opening_char, closing_char)
    closing_char_for(opening_char) != closing_char
  end

  def score_for(closing_char)
    scores_mapping.fetch(closing_char)
  end

  def closing_char_for(opening_char)
    CHUNK_PAIRS.fetch(opening_char)
  end
end

class SyntaxChecker < SyntaxTool
  def scores_mapping 
    {
      ')' => 3,
      ']' => 57,
      '}' => 1_197,
      '>' => 25_137
    }.freeze
  end

  def total_syntax_error_score
    total_score = 0
    IO.foreach(@file) do |line|
      total_score += one_line_score(line.chomp)
    end
    
    total_score
  end

  private

  def one_line_score(line)
    stack = Stack.new

    line.each_char do |char|
      if open_char?(char)
        stack.push(char)
      else
        previous_char = stack.pop
        return score_for(char) if invalid_chunk?(previous_char, char)
      end
    end

    0
  end
end

class AutocompleteTool < SyntaxTool
  def scores_mapping 
    {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
    }.freeze
  end

  def middle_completion_score
    all_scores = []

    IO.foreach(@file) do |line|
      all_scores.push one_line_score(line.chomp)
    end

    all_scores.compact!
    all_scores.sort[all_scores.length / 2]
  end

  def one_line_score(line)
    stack = Stack.new

    line.each_char do |char|
      if open_char?(char)
        stack.push(char)
      else
        previous_char = stack.pop
        return if invalid_chunk?(previous_char, char)
      end
    end

    total_score = 0
    while next_char = stack.pop
      total_score = (total_score * 5) + score_for(closing_char_for(next_char))
    end

    total_score
  end
end

checker = SyntaxChecker.new(file)
p checker.total_syntax_error_score

autocomplete_tool = AutocompleteTool.new(file)
p autocomplete_tool.middle_completion_score
