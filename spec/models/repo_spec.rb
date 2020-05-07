require 'rails_helper'

RSpec.describe Repo, type: :model do
  it 'should have a name' do
    repo = Repo.new('Repo Name', 'Repo Link')
    expect(repo.name).to eq('Repo Name')
    expect(repo.link).to eq('Repo Link')
    expect(repo).to be_a_kind_of(Repo)
  end
end
