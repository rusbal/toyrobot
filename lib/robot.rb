class Robot
  def initialize
    @state = {}
  end

  def place(x, y, direction)
    @state = { x: x, y: y, direction: direction }
  end

  def placed?
    !@state.empty?
  end

  private

  attr_accessor :state
end
