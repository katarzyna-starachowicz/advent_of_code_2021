require 'bingo_first_win'

RSpec.describe BingoFirstWin, '#final_score' do
  subject(:game) { described_class.new(file) }

  context 'with puzzle test input' do
    let(:file) { File.open('./spec/puzzle_test_input.txt') }

    it 'returns the final score' do
      expect(game.final_score).to eq(4_512)
    end
  end
end
