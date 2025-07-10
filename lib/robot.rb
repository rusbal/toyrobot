# frozen_string_literal: true

require_relative './state'

# Robot is the main class
class Robot
  COMMANDS = %w[PLACE LEFT RIGHT MOVE REPORT].freeze

  def self.call(commands)
    new.call(commands)
  end

  def call(commands)
    command_list = commands.squeeze(' ').split("\n")

    success = command_list.map do |command_and_args|
      run(command_and_args)
    end.compact.last

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

  def run(command_and_args)
    command, x, y, direction = command_and_args.split(/[ ,]/, 4)

    return unless processable_command?(command)

    send(command.downcase, x&.to_i, y&.to_i, direction&.strip)
  end

  def processable_command?(command)
    return false unless COMMANDS.include?(command)
    return false if command != 'PLACE' && !state.ready?

    true
  end

  def change_direction_90_degrees(direction)
    if direction == :left
      index_delta = -1
    elsif direction == :right
      index_delta = 1
    end

    State::DIRECTIONS[compute_index(index_delta)]
  end

  def compute_index(index_delta)
    index = State::DIRECTIONS.index(state.direction) + index_delta

    if index.negative?
      3
    elsif index > 3
      0
    else
      index
    end
  end
end
