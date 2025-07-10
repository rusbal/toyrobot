# frozen_string_literal: true

# State saves the x and y coordinates, and direction
class State
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze
  VALID_POINT = ->(n) { n >= 0 && n <= 4 }

  %i[x y direction].each do |attr|
    define_method(attr) do
      @state[attr]
    end
  end

  attr_reader :state

  def save(new_state)
    @state ||= {}
    new_state = { **@state, **new_state }

    return unless valid?(**new_state)

    @state = new_state
  end

  def ready?
    @state.any?
  end

  def move
    if north?
      save(y: y + 1)
    elsif south?
      save(y: y - 1)
    elsif east?
      save(x: x + 1)
    elsif west?
      save(x: x - 1)
    end
  end

  def formatted_report
    @state.values.join(',')
  end

  private

  def initialize
    @state = {}
  end

  def valid?(x: nil, y: nil, direction: nil)
    return false unless x && y && direction

    VALID_POINT.call(x) &&
      VALID_POINT.call(y) &&
      DIRECTIONS.include?(direction)
  end

  DIRECTIONS.each do |direction|
    define_method("#{direction.downcase}?") do
      @state[:direction] == direction
    end
  end
end
