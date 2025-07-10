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

  private

  attr_accessor :state

  def valid?(*args)
    x, y, direction = *args

    VALID_POINT.call(x) &&
      VALID_POINT.call(y) &&
      DIRECTIONS.include?(direction)
  end
end
