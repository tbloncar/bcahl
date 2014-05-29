require 'spec_helper'

describe Bulletin do
  it 'should require just a message' do
    Bulletin.create(message: "This is a message")
  end

  it 'should be inactive by default' do
    Bulletin.new.active.should be_false
  end
end
