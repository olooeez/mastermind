# frozen_string_literal: true

# Feedback class to generate feedbacks on guesses
class Feedback
  # rubocop:disable Metrics/AbcSize
  def self.give_feedback(code, guess)
    feedback_hash = { correct_positions: 0, wrong_positions: 0 }
    code = code.to_s.split('')
    guess = guess.to_s.split('')

    correct_positions = guess.each_index.select { |i| guess[i] == code[i] }
    feedback_hash[:correct_positions] += correct_positions.size
    correct_positions.each { |i| guess[i] = code[i] = nil }

    wrong_positions = guess.compact.count { |c| code.include?(c) }
    feedback_hash[:wrong_positions] += wrong_positions

    feedback_hash
  end
  # rubocop:enable Metrics/AbcSize

  def self.print_feedback(feedback)
    print '> Feedback: '

    feedback[:correct_positions].times { print "\u{1f7e2}" }
    feedback[:wrong_positions].times { print "\u{1f7e0}" }

    puts 'No feedbacks :(' if feedback.values.all?(&:zero?)

    print "\n"
  end
end
