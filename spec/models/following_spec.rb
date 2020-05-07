require 'rails_helper'

RSpec.describe Following, type: :model do
  it 'should have a name' do
    following = Following.new('Tron', 'Profile Link')
    expect(following.name).to eq('Tron')
    expect(following.link).to eq('Profile Link')
    expect(following).to be_a_kind_of(Following)
  end
end
