require_relative 'player'

class Human < Player
  def initialize
    super('McLovin')
  end

  def make_code
    create_input(:code)
  end

  def make_guess(_feedback)
    create_input(:guess)
  end

  private

  def create_input(type)
    input = nil

    loop do
      print "• Enter the #{type}, #{name}: "
      input = gets.chomp

      break if valid_input?(input)

      puts "> Error: Invalid #{type}. It needs to be a 4 digit number between 1 and 6."
    end

    input
  end

  def valid_input?(input)
    input.match?(/\A[1-6]{4}\z/)
  end
end
