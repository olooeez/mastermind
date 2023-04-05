require_relative '../lib/feedback'

require 'rspec'

describe Feedback do
  describe '.give_feedback' do
    context 'when given correct guess' do
      it 'returns a hash with correct_positions and wrong_positions set to 4' do
        expect(Feedback.give_feedback(1234, 1234)).to eq({ correct_positions: 4, wrong_positions: 0 })
      end
    end

    context 'when given a guess with all correct numbers but in the wrong position' do
      it 'returns a hash with correct_positions set to 0 and wrong_positions set to 4' do
        expect(Feedback.give_feedback(1234, 4321)).to eq({ correct_positions: 0, wrong_positions: 4 })
      end
    end

    context 'when given a guess with some correct numbers and some in the wrong position' do
      it 'returns a hash with correct_positions and wrong_positions set to the correct values' do
        expect(Feedback.give_feedback(1234, 3214)).to eq({ correct_positions: 2, wrong_positions: 2 })
      end
    end

    context 'when given an incorrect guess' do
      it 'returns a hash with correct_positions and wrong_positions set to 0' do
        expect(Feedback.give_feedback(1234, 5678)).to eq({ correct_positions: 0, wrong_positions: 0 })
      end
    end
  end

  describe '.print_feedback' do
    context 'when given a feedback hash with correct_positions and wrong_positions set to non-zero values' do
      it 'prints the feedback in the correct format' do
        expect { Feedback.print_feedback({ correct_positions: 2, wrong_positions: 2 }) }.to output("> Feedback: ✔ ✔ ✖ ✖ \n").to_stdout
      end
    end

    context 'when given a feedback hash with correct_positions and wrong_positions set to 0' do
      it 'prints the correct message' do
        expect { Feedback.print_feedback({ correct_positions: 0, wrong_positions: 0 }) }.to output("> Feedback: > No feedbacks :(\n\n").to_stdout
      end
    end
  end
end
