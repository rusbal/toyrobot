class Robot
  VALID_COMMANDS = ['PLACE', 'LEFT', 'RIGHT', 'MOVE', 'REPORT'].freeze
  DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST'].freeze
  VALID_POINT = ->(n) { n && n >= 0 && n <= 4 }

  def self.call(commands)
    new.call(commands)
  end

  def call(commands)
    commands.split("\n").map do |command_and_args|
      exec_one_command(command_and_args)
    end

    "#{state[:x]},#{state[:y]},#{state[:direction]}"
  end

  def place(*args)
    if valid?(*args)
      @state = { x: args[0], y: args[1], direction: args[2] }
    end
  end

  def left(...)
    change_direction_90_degrees(__method__)
  end

  def right(...)
    change_direction_90_degrees(__method__)
  end

  def move(...)
    new_state = state.dup

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

  def report(...)
    state
  end

  def placed?
    !state.empty?
  end

  private

  attr_accessor :state

  def initialize
    @state = {}
  end

  def exec_one_command(command_and_args)
    command, x, y, direction = command_and_args.squeeze(' ').split(/[ ,]/, 4)

    x = x&.to_i
    y = y&.to_i
    direction = direction&.strip

    # NO OP
    return unless VALID_COMMANDS.include?(command)

    send(command.downcase, x, y, direction)
  end

  def valid?(*args)
    x, y, direction = *args

    return false unless x && y && direction

    valid_coords?(x, y) && DIRECTIONS.include?(direction)
  end

  def valid_coords?(x, y)
    VALID_POINT.call(x) && VALID_POINT.call(y)
  end

  def change_direction_90_degrees(direction)
    if direction == :left
      change = -1
    elsif direction == :right
      change = 1
    end

    index = DIRECTIONS.index(state[:direction]) + change

    if index < 0
      index = 3
    elsif index > 3
      index = 0
    end

    state[:direction] = DIRECTIONS[index]
  end

  DIRECTIONS.each do |direction|
    define_method("#{direction.downcase}?") do
      state[:direction] == direction
    end
  end
end
