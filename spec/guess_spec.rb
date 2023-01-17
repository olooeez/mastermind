require_relative '../lib/guess'

require 'rspec'

describe Guess do
  let(:guess) { Guess.new }

  describe '#initialize' do
    it 'sets the @init_guess instance variable to 1122' do
      expect(guess.instance_variable_get(:@init_guess)).to eq(1122)
    end
  end

  describe '#create_guess' do
    context 'when given a feedback hash' do
      it 'eliminates candidates from @candidates based on the feedback' do
        feedback_hash = { correct_positions: 1, wrong_positions: 2 }
        guess_number = 1234
        expect(guess).to receive(:eliminate).with(feedback_hash, guess_number)
        guess.create_guess(feedback_hash, guess_number)
      end

      it 'returns the next candidate from @candidates' do
        feedback_hash = { correct_positions: 1, wrong_positions: 2 }
        guess_number = 1234
        expect(guess.create_guess(feedback_hash, guess_number)).to eq('1123')
      end
    end

    context 'when not given a feedback hash' do
      it 'returns @init_guess as a string' do
        expect(guess.create_guess(nil, nil)).to eq('1122')
      end
    end
  end
end
