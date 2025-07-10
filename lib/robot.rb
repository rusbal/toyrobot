require_relative './state'

class Robot
  COMMANDS = ['PLACE', 'LEFT', 'RIGHT', 'MOVE', 'REPORT'].freeze
  DIRECTIONS = ['NORTH', 'EAST', 'SOUTH', 'WEST'].freeze

  def self.call(commands)
    new.call(commands)
  end

  def call(commands)
    success = commands.split("\n").map do |command_and_args|
      exec_one_command(command_and_args)
    end.last

    state.formatted_report if success
  end

  def place(*args)
    state.save(x: args[0], y: args[1], direction: args[2])
  end

  def left(*)
    state.save(direction: change_direction_90_degrees(__method__))
  end

  def right(*)
    state.save(direction: change_direction_90_degrees(__method__))
  end

  def move(*)
    state.move
  end

  def report(*)
    state.formatted_report
  end

  private

  def initialize
    @state = State.new
  end

  attr_accessor :state

  def exec_one_command(command_and_args)
    command, x, y, direction = command_and_args.squeeze(' ').split(/[ ,]/, 4)

    x = x&.to_i
    y = y&.to_i
    direction = direction&.strip

    # NOOP
    return unless COMMANDS.include?(command)
    return if command != 'PLACE' && !state.ready?

    send(command.downcase, x, y, direction)
  end

  def change_direction_90_degrees(direction)
    if direction == :left
      change = -1
    elsif direction == :right
      change = 1
    end

    index = DIRECTIONS.index(state.direction) + change

    if index < 0
      index = 3
    elsif index > 3
      index = 0
    end

    DIRECTIONS[index]
  end
end
