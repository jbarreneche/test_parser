require_relative 'spec_helper'

describe Life do

  it 'actually lives' do
    Life.new.should be_alive
  end

  context 'with death sentence' do
    subject { Life.new.tap {|l| l.sentence_to_death! }}
    it { should be_alive }
  end

end