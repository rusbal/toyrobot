require 'spec_helper'

RSpec.describe Robot do
  describe '#first_test' do
    it 'returns expected value' do
      expect(Robot.new.first_test).to eq("We're good")
    end
  end
end
