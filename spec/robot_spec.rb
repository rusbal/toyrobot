require 'spec_helper'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  describe '#placed?' do
    context 'not placed' do
      it 'will return false' do
        expect(robot.placed?).to eq false
      end
    end

    context 'placed' do
      it 'will return true' do
        robot.place(0, 0, 'NORTH')
        expect(robot.placed?).to eq true
      end
    end
  end
end
