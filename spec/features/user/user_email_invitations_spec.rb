require 'rails_helper'

describe "A logged in user" do
  before(:each) do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "sees a link to invite people by email" do
    visit '/dashboard'
    expect(page).to have_link('Send an Invite')
    
    click_link 'Send an Invite'
    expect(current_path).to eq('/invite')
  end

  scenario "can send a link to invite someone by email" do
    visit '/dashboard'
    click_link 'Send an Invite'
    fill_in "Github Handle",	with: "zachholcomb" 
    click_on 'Send Invite'
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Successfully sent invite!')
  end
end