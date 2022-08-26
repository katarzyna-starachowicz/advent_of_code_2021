require 'bingo_last_win'

RSpec.describe BingoLastWin, '#final_score' do
  subject(:game) { described_class.new(file) }

  context 'with puzzle test input' do
    let(:file) { File.open('./spec/puzzle_test_input.txt') }

    it 'returns the final score' do
      expect(game.final_score).to eq(1_924)
    end
  end
end
