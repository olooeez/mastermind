require_relative './feedback'

class Guess
  def initialize
    @init_guess = 1122
    @candidates = [1, 2, 3, 4, 5, 6].repeated_permutation(4).to_a.map { |x| x.join.to_i } - [@init_guess]
  end

  def create_guess(feedback_hash, guess)
    return @init_guess.to_s unless feedback_hash

    eliminate(feedback_hash, guess)

    @candidates.shift.to_s
  end

  protected

  def eliminate(feedback_hash, guess)
    @candidates.select! do |value|
      Feedback.give_feedback(guess, value) == feedback_hash
    end
  end
end
