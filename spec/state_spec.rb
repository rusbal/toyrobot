# frozen_string_literal: true

require 'spec_helper'

RSpec.describe State do
  let(:state) { State.new }

  describe '#ready?' do
    context 'no data' do
      it 'returns false' do
        expect(state.ready?).to eq false
      end
    end

    context 'with data' do
      it 'returns true' do
        state.save(x: 0, y: 0, direction: 'NORTH')
        expect(state.ready?).to eq true
      end
    end
  end

  describe '#move' do
    context 'valid move' do
      it 'moves in the direction' do
        state.save(x: 0, y: 0, direction: 'NORTH')
        expect(state.move).to be_truthy
        expect(state.x).to eq 0
        expect(state.y).to eq 1
      end
    end

    context 'invalid move' do
      it 'does not move' do
        state.save(x: 0, y: 4, direction: 'NORTH')
        expect(state.move).to be_falsy
        expect(state.x).to eq 0
        expect(state.y).to eq 4
      end
    end
  end

  describe '#formatted_report' do
    context 'no data' do
      it 'returns formatted data' do
        expect(state.formatted_report).to eq ''
      end
    end

    context 'with data' do
      it 'returns formatted data' do
        state.save(x: 0, y: 4, direction: 'NORTH')
        expect(state.formatted_report).to eq '0,4,NORTH'
      end
    end
  end

  describe '#save' do
    context 'invalid data' do
      it 'does not save' do
        state.save(x: 0, y: 5, direction: 'NORTH')
        expect(state.x).to eq nil
        expect(state.y).to eq nil
        expect(state.direction).to eq nil
      end

      it 'keeps old valid data' do
        state.save(x: 0, y: 4, direction: 'NORTH')
        state.save(x: 0, y: 5, direction: 'NORTH')

        expect(state.x).to eq 0
        expect(state.y).to eq 4
        expect(state.direction).to eq 'NORTH'
      end
    end

    context 'valid data' do
      before do
        state.save(x: 0, y: 4, direction: 'NORTH')
      end

      it 'saves to state' do
        expect(state.x).to eq 0
        expect(state.y).to eq 4
        expect(state.direction).to eq 'NORTH'
      end

      it 'can save some field' do
        state.save(x: 3)
        expect(state.x).to eq 3
        expect(state.y).to eq 4
        expect(state.direction).to eq 'NORTH'

        state.save(y: 2)
        expect(state.x).to eq 3
        expect(state.y).to eq 2
        expect(state.direction).to eq 'NORTH'

        state.save(direction: 'EAST')
        expect(state.x).to eq 3
        expect(state.y).to eq 2
        expect(state.direction).to eq 'EAST'
      end
    end
  end
end
