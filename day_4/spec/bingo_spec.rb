require 'Bingo'

RSpec.describe Bingo, '#final_score' do
  subject(:game) { described_class.new(file) }

  context 'with puzzle 1 test input' do
    let(:file) { File.open('./spec/puzzle_1_test_input.txt') }

    it 'returns the final score' do
      expect(game.final_score).to eq(4_512)
    end
  end
end
