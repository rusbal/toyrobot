# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Given tests on toy robot.md' do
  subject { Robot.call(commands) }

  describe 'first test' do
    let(:commands) do
      <<~COMMANDS
        PLACE 0,0, NORTH
        MOVE
        REPORT
      COMMANDS
    end

    it 'returns expected string' do
      expect(subject).to eq '0,1,NORTH'
    end
  end

  describe 'second test' do
    let(:commands) do
      <<~COMMANDS
        PLACE 0,0,NORTH
        LEFT
        REPORT
      COMMANDS
    end

    it 'returns expected string' do
      expect(subject).to eq '0,0,WEST'
    end
  end

  describe 'third test' do
    let(:commands) do
      <<~COMMANDS
        PLACE 1,2,EAST
        MOVE
        MOVE
        LEFT
        MOVE
        REPORT
      COMMANDS
    end

    it 'returns expected string' do
      expect(subject).to eq '3,3,NORTH'
    end
  end
end
