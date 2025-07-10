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
      context 'with valid placement' do
        it 'will return true' do
          robot.place(0, 0, 'NORTH')
          expect(robot.placed?).to eq true
        end
      end

      context 'with invalid placement x' do
        it 'will return false' do
          robot.place(5, 0, 'NORTH')
          expect(robot.placed?).to eq false
        end
      end

      context 'with invalid placement y' do
        it 'will return false' do
          robot.place(0, 5, 'NORTH')
          expect(robot.placed?).to eq false
        end
      end

      context 'with invalid placement direction' do
        it 'will return false' do
          robot.place(0, 0, 'AMERICA')
          expect(robot.placed?).to eq false
        end
      end
    end
  end
end
