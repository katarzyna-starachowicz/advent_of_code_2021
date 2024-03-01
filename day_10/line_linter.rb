require_relative 'stack'

class LineLinter
  CHUNK_PAIRS = {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
  }.freeze

  SCORES_MAPPING = {
    ')' => { syntax_error_score: 3, completion_score: 1 },
    ']' => { syntax_error_score: 57, completion_score: 2 },
    '}' => { syntax_error_score: 1_197, completion_score: 3 },
    '>' => { syntax_error_score: 25_137, completion_score: 4 }
  }.freeze

  def initialize(line)
    @line = line
    find_invalid_chunk!
  end

  def valid?
    return @valid if defined? @valid

    @valid = invalid_chunk.nil?
  end

  def syntax_error_score
    raise 'Syntax error score cannot be calculated for valid syntax' if valid?

    retrun @syntax_error_score if defined? @syntax_error_score

    @syntax_error_score = SCORES_MAPPING.dig(invalid_chunk, :syntax_error_score)
  end

  def completion_score
    raise 'Invalid syntax cannot be completed' unless valid?

    retrun @completion_score if defined? @completion_score

    while next_char = @stack.pop
      score = ((score || 0) * 5) + SCORES_MAPPING.dig(closing_char_for(next_char), :completion_score)
    end

    @completion_score = score
  end

  private

  def find_invalid_chunk!
    @stack = Stack.new

    line.each_char do |char|
      if open_char?(char)
        @stack.push(char)
      else
        previous_char = @stack.pop
        if invalid_chunk?(previous_char, char)
          return @invalid_chunk = char
        end
      end
    end

    @invalid_chunk = nil
  end

  def open_char?(char)
    CHUNK_PAIRS.keys.include?(char)
  end
  
  def invalid_chunk?(opening_char, closing_char)
    closing_char_for(opening_char) != closing_char
  end

  def closing_char_for(opening_char)
    CHUNK_PAIRS.fetch(opening_char)
  end

  attr_reader :line, :invalid_chunk
end
