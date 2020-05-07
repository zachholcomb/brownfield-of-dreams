require 'rails_helper'

RSpec.describe Follower, type: :model do
  it 'should have a name' do
    follower = Follower.new('Tron', 'Profile Link')
    expect(follower.name).to eq('Tron')
    expect(follower.link).to eq('Profile Link')
    expect(follower).to be_a_kind_of(Follower)
  end
end
