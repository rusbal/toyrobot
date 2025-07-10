require 'debug'

class Robot
  DIRECTIONS = ['NORTH', 'SOUTH', 'EAST', 'WEST'].freeze
  VALID_POINT = ->(n) { n >= 0 && n <= 4 }

  def initialize
    @state = {}
  end

  def place(*args)
    if valid?(*args)
      @state = { x: args[0], y: args[1], direction: args[2] }
    end
  end

  def placed?
    !@state.empty?
  end

  def move
    new_state = @state.dup

    if north?
      new_state[:y] += 1
    elsif south?
      new_state[:y] -= 1
    elsif east?
      new_state[:x] += 1
    elsif west?
      new_state[:x] -= 1
    end

    if valid_coords?(new_state[:x], new_state[:y])
      @state = new_state
    end
  end

  def report
    @state
  end

  private

  attr_accessor :state

  def valid?(*args)
    x, y, direction = *args

    valid_coords?(x, y) && DIRECTIONS.include?(direction)
  end

  def valid_coords?(x, y)
    VALID_POINT.call(x) && VALID_POINT.call(y)
  end

  DIRECTIONS.each do |direction|
    define_method("#{direction.downcase}?") do
      @state[:direction] == direction
    end
  end
end
