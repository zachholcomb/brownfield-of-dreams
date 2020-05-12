require 'rails_helper'

describe "A logged in user" do
  before(:each) do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "sees a link to invite people by email" do
    visit '/dashboard'
    expect(page).to have_button('Send an Invite')
    
    click_button 'Send an Invite'
    expect(current_path).to eq('/invite')
  end

  scenario "can send a link to invite someone by email" do
    valid_response = File.read('spec/fixtures/github_username.json')
    stub_request(:get, "https://api.github.com/users/zachholcomb").to_return(status: 200, body: valid_response)
    visit '/dashboard'
    click_button 'Send an Invite'
    
    expect(current_path).to eq('/invite')
    
    fill_in :github_handle,	with: "zachholcomb" 
    click_on 'Send Invite'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Successfully sent invite!')
  end

  scenario "cannot send a link to an invalid github handle" do
    no_email_response = File.read('spec/fixtures/github_no_email.json')
    stub_request(:get, "https://api.github.com/users/zachholcomb").to_return(status:200, body: no_email_response)

    visit '/dashboard'
    click_on "Send an Invite"

    fill_in :github_handle, with: "zachholcomb"
    click_on 'Send Invite'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end