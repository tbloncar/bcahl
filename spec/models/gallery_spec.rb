require 'spec_helper'

describe Gallery do
  subject(:gallery) { FactoryGirl.build(:gallery) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:date_start) }
  it { should validate_presence_of(:date_end) }

  it 'should have a default cover photo URL' do
  	gallery.cover_photo_path.should be_true
  end
end
