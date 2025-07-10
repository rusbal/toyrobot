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

  describe '#move' do
    context 'valid' do
      it 'moves one square to the right direction' do
        robot.place(0, 0, 'NORTH')
        robot.move
        expect(robot.report).to eq(x: 0, y: 1, direction: 'NORTH')
      end
    end

    context 'invalid using with south' do
      it 'does not move' do
        robot.place(0, 0, 'SOUTH')
        robot.move
        expect(robot.report).to eq(x: 0, y: 0, direction: 'SOUTH')
      end
    end

    context 'invalid using with north' do
      it 'does not move' do
        robot.place(0, 4, 'NORTH')
        robot.move
        expect(robot.report).to eq(x: 0, y: 4, direction: 'NORTH')
      end
    end

    context 'invalid using with east' do
      it 'does not move' do
        robot.place(4, 0, 'EAST')
        robot.move
        expect(robot.report).to eq(x: 4, y: 0, direction: 'EAST')
      end
    end

    context 'invalid using with west' do
      it 'does not move' do
        robot.place(0, 0, 'WEST')
        robot.move
        expect(robot.report).to eq(x: 0, y: 0, direction: 'WEST')
      end
    end
  end

  describe '#left' do
    context 'north' do
      it 'rotates 90 degrees' do
        robot.place(0, 0, 'NORTH')
        robot.left
        expect(robot.report[:direction]).to eq('WEST')
      end
    end

    context 'west' do
      it 'rotates 90 degrees' do
        robot.place(0, 0, 'WEST')
        robot.left
        expect(robot.report[:direction]).to eq('SOUTH')
      end
    end

    context 'south' do
      it 'rotates 90 degrees' do
        robot.place(0, 0, 'SOUTH')
        robot.left
        expect(robot.report[:direction]).to eq('EAST')
      end
    end

    context 'east' do
      it 'rotates 90 degrees' do
        robot.place(0, 0, 'EAST')
        robot.left
        expect(robot.report[:direction]).to eq('NORTH')
      end
    end
  end
end
