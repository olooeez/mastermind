require_relative 'player/computer'
require_relative 'player/human'
require_relative 'feedback'

class Game
  TOTAL_ROUNDS = 12

  def initialize
    @number_of_games = nil
    @maker = nil
    @breaker = nil
    @feedback = nil

    @score = Hash.new(0)
  end

  def run
    puts 'Welcome to Mastermind!'

    @number_of_games = receive_total_number_of_games
    @maker, @breaker = receive_players

    play_rounds

    result_game
  end

  private

  def play_rounds
    @number_of_games.times do |round|
      puts "> Current round: #{round}"

      puts "> Code Maker:\t#{@maker.name}\n> Code Breaker:\t#{@breaker.name}"

      play

      @maker, @breaker = @breaker, @maker

      @feedback = nil
    end
  end

  def play
    @code = @maker.make_code

    TOTAL_ROUNDS.times do |move_count|
      puts "• Move #{move_count}"

      @guess = @breaker.make_guess(@feedback)

      @feedback = Feedback.give_feedback(@guess, @code)

      Feedback.print_feedback(@feedback)

      @score[@maker] += 1

      if code_broken?
        puts '> The code was broken.'
        print_score_board
        break
      end

      if move_count == 11
        puts "> The code (#{@code}) wasn't broken."
        print_score_board
      end

      sleep 0.75
    end
  end

  def receive_players
    maker = nil
    breaker = nil
    choice = nil

    loop do
      print '• Type 0 if you want to be the code maker or type 1 if you want to be the code breaker: '
      choice = gets.chomp

      break if %w[0 1].include?(choice)

      puts '> Error: Invalid choice (it needs to be 0 or 1).'
    end

    choice = choice.to_i

    if choice.zero?
      maker = Human.new
      breaker = Computer.new
    elsif choice == 1
      maker = Computer.new
      breaker = Human.new
    end

    [maker, breaker]
  end

  def receive_total_number_of_games
    number_of_games = nil

    loop do
      print '• Type the total numbers of games: '
      number_of_games = gets.chomp.to_i

      break if !number_of_games.zero? && number_of_games.even?

      puts '> Error: Invalid number of games (can\'t be zero and needs to be even).'
    end

    number_of_games
  end

  def result_game
    if @score[@maker] == @score[@breaker]
      puts '> There is a draw!'
    else
      puts "> The winner is #{@score.key(@score.values.max)}. This the end of the game."
    end
  end

  def code_broken?
    @guess == @code
  end

  def print_score_board
    puts '> The score board:'
    puts "> #{@maker.name}: #{@score[@maker]}"
    puts "> #{@breaker.name}: #{@score[@breaker]}"
  end
end
