require 'spec_helper'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  describe '#place' do
    context 'with valid placement' do
      it 'assigns place' do
        robot.place(0, 0, 'NORTH')
        expect(robot.report).to eq "0,0,NORTH"
      end
    end

    context 'with invalid placement x' do
      it 'does not assign place' do
        robot.place(5, 0, 'NORTH')
        expect(robot.report).to eq ""
      end
    end

    context 'with invalid placement y' do
      it 'does not assign place' do
        robot.place(0, 5, 'NORTH')
        expect(robot.report).to eq ""
      end
    end

    context 'with invalid placement direction' do
      it 'does not assign place' do
        robot.place(0, 0, 'AMERICA')
        expect(robot.report).to eq ""
      end
    end
  end

  describe '#move' do
    context 'valid' do
      it 'moves one square to the right direction' do
        robot.place(0, 0, 'NORTH')
        robot.move
        expect(robot.report).to eq "0,1,NORTH"
      end
    end

    context 'invalid using with south' do
      it 'does not move' do
        robot.place(0, 0, 'SOUTH')
        robot.move
        expect(robot.report).to eq "0,0,SOUTH"
      end
    end

    context 'invalid using with north' do
      it 'does not move' do
        robot.place(0, 4, 'NORTH')
        robot.move
        expect(robot.report).to eq "0,4,NORTH"
      end
    end

    context 'invalid using with east' do
      it 'does not move' do
        robot.place(4, 0, 'EAST')
        robot.move
        expect(robot.report).to eq "4,0,EAST"
      end
    end

    context 'invalid using with west' do
      it 'does not move' do
        robot.place(0, 0, 'WEST')
        robot.move
        expect(robot.report).to eq "0,0,WEST"
      end
    end
  end

  describe '#left' do
    context 'north' do
      it 'rotates 90 degrees to the left' do
        robot.place(0, 0, 'NORTH')
        robot.left
        expect(robot.report).to eq "0,0,WEST"
      end
    end

    context 'west' do
      it 'rotates 90 degrees to the left' do
        robot.place(0, 0, 'WEST')
        robot.left
        expect(robot.report).to eq "0,0,SOUTH"
      end
    end

    context 'south' do
      it 'rotates 90 degrees to the left' do
        robot.place(0, 0, 'SOUTH')
        robot.left
        expect(robot.report).to eq "0,0,EAST"
      end
    end

    context 'east' do
      it 'rotates 90 degrees to the left' do
        robot.place(0, 0, 'EAST')
        robot.left
        expect(robot.report).to eq "0,0,NORTH"
      end
    end
  end

  describe '#right' do
    context 'north' do
      it 'rotates 90 degrees to the right' do
        robot.place(0, 0, 'NORTH')
        robot.right
        expect(robot.report).to eq "0,0,EAST"
      end
    end

    context 'east' do
      it 'rotates 90 degrees to the right' do
        robot.place(0, 0, 'EAST')
        robot.right
        expect(robot.report).to eq "0,0,SOUTH"
      end
    end

    context 'south' do
      it 'rotates 90 degrees to the right' do
        robot.place(0, 0, 'SOUTH')
        robot.right
        expect(robot.report).to eq "0,0,WEST"
      end
    end

    context 'west' do
      it 'rotates 90 degrees to the right' do
        robot.place(0, 0, 'WEST')
        robot.right
        expect(robot.report).to eq "0,0,NORTH"
      end
    end
  end
end
