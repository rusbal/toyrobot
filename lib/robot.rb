class Robot
  VALID_COMMANDS = ['PLACE', 'LEFT', 'RIGHT', 'MOVE', 'REPORT'].freeze
  DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST'].freeze
  VALID_POINT = ->(n) { n && n >= 0 && n <= 4 }

  def self.call(commands)
    new.call(commands)
  end

  def call(commands)
    success = commands.split("\n").map do |command_and_args|
      exec_one_command(command_and_args)
    end.last

    formatted_report if success
  end

  def place(*args)
    save_state(x: args[0], y: args[1], direction: args[2])
  end

  def left(*)
    save_state(direction: change_direction_90_degrees(__method__))
  end

  def right(*)
    save_state(direction: change_direction_90_degrees(__method__))
  end

  def move(*)
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

    save_state(new_state)
  end

  def report(*)
    state
  end

  def formatted_report
    state.values.join(',')
  end

  def placed?
    state.any?
  end

  private

  attr_accessor :state

  def initialize
    save_state({})
  end

  def save_state(new_state)
    @state ||= {}
    new_state = { **@state, **new_state }

    if valid?(new_state)
      @state = new_state
    end
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

  def valid?(kwargs)
    x = kwargs[:x]
    y = kwargs[:y]
    direction = kwargs[:direction]

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

    DIRECTIONS[index]
  end

  DIRECTIONS.each do |direction|
    define_method("#{direction.downcase}?") do
      state[:direction] == direction
    end
  end
end
