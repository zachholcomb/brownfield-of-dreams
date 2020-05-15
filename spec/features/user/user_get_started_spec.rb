require 'rails_helper'

describe 'User visits get started' do
  scenario 'they see the pages info' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/get_started'
    expect(page).to have_content('Get Started')

  end
end