class BingoLastWin
  attr_reader :drawn_numbers, :boards

  def initialize(input_file)
    @drawn_numbers = input_file.gets.chomp.split(',')
    @boards = []
    @wins = []
    prepare_boards(input_file)
  end

  def final_score
    drawn_numbers.each do |drawn_number|
      boards.each do |board|
        next if board.wins? 
        
        board.mark_number(drawn_number)
        @wins.push(board.final_score) if board.wins?
      end
    end

    @wins.last
  end

  private

  def prepare_boards(file)
    file.readlines
      .map { |line| line.strip.split }
      .delete_if(&:empty?)
      .flatten
      .each_slice(Board::BOARD_LENGTH**2) { |data| @boards.push(Board.new(data)) }

    file.close
  end
end


class Board
  NumberPosition = Struct.new(:row, :column)
  BOARD_LENGTH = 5

  def initialize(data)
    @all_numbers = data
    @marked_numbers = []
    @marked_columns = Hash.new(0)
    @marked_rows = Hash.new(0)
  end

  def mark_number(drown_number)
    return unless @all_numbers.include?(drown_number)

    mark_columns_and_rows(drown_number)
    @marked_numbers.push(drown_number)
  end

  def wins?
    @marked_rows.values.any? { |v| v == BOARD_LENGTH } ||
      @marked_columns.values.any? { |v| v == BOARD_LENGTH }
  end

  def final_score
    sum_of_all_unmarked_number = (@all_numbers - @marked_numbers).map(&:to_i).sum
    sum_of_all_unmarked_number * @marked_numbers.last.to_i
  end

  private

  def mark_columns_and_rows(drown_number)
    number_position = catch(:number_found) do
      @all_numbers.each_slice(BOARD_LENGTH).with_index do |row, row_index|
        row.each.with_index do |number, column_index|
          throw :number_found, NumberPosition.new(row_index, column_index) if drown_number == number
        end
      end
    end

    @marked_rows[number_position.row] = @marked_rows[number_position.row] + 1
    @marked_columns[number_position.column] = @marked_columns[number_position.column] + 1
  end
end

