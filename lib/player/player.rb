# frozen_string_literal: true

# Player parent class for Human and Computer players
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
