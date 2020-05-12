require 'rails_helper'

RSpec.describe Invite do
  describe 'validations' do
    it { should validate_presence_of(:github_handle) }
  end
end