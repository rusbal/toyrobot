require 'spec_helper'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  describe '#place' do
    context 'with valid placement' do
      it 'will return true' do
        robot.place(0, 0, 'NORTH')
        expect(robot.report).to eq "0,0,NORTH"
      end
    end

    context 'with invalid placement x' do
      it 'will return false' do
        robot.place(5, 0, 'NORTH')
        expect(robot.report).to eq ""
      end
    end

    context 'with invalid placement y' do
      it 'will return false' do
        robot.place(0, 5, 'NORTH')
        expect(robot.report).to eq ""
      end
    end

    context 'with invalid placement direction' do
      it 'will return false' do
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

  describe 'given tests on toy robot.md' do
    subject { Robot.call(commands) }

    describe 'first test' do
      let(:commands) { <<~COMMANDS
          PLACE 0,0, NORTH
          MOVE
          REPORT
        COMMANDS
      }

      it 'returns expected string' do
        expect(subject).to eq "0,1,NORTH"
      end
    end

    describe 'second test' do
      let(:commands) { <<~COMMANDS
          PLACE 0,0,NORTH
          LEFT
          REPORT
        COMMANDS
      }

      it 'returns expected string' do
        expect(subject).to eq "0,0,WEST"
      end
    end

    describe 'third test' do
      let(:commands) { <<~COMMANDS
          PLACE 1,2,EAST
          MOVE
          MOVE
          LEFT
          MOVE
          REPORT
        COMMANDS
      }

      it 'returns expected string' do
        expect(subject).to eq "3,3,NORTH"
      end
    end
  end
end
