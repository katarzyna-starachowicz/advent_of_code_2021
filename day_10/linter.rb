require_relative 'line_linter'

class Linter
  def initialize(file_path)
    @line_linters = []
    fill_lines!(file_path)
  end
  
  def total_syntax_error_score
    return @total_syntax_error_score if @total_syntax_error_score

    @total_syntax_error_score = 
      line_linters.inject(0) do |total_score, line_linter|
        next total_score if line_linter.valid?

        total_score + line_linter.syntax_error_score
      end
  end

  def middle_completion_score
    return @middle_completion_score if defined? @middle_completion_score

    all_scores = line_linters.inject([]) do |scores, line_linter|
      next scores unless line_linter.valid?

      scores.push line_linter.completion_score
    end

    @middle_completion_score = all_scores.sort[all_scores.length / 2]
  end

  private
  attr_accessor :line_linters

  def fill_lines!(file_path)
    IO.foreach(file_path) do |line|
      line_linters << LineLinter.new(line.chomp)
    end
  end
end
