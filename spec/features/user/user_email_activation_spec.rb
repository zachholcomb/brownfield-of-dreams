require 'rails_helper'

describe 'As a user' do
  scenario 'I must activate my account by checking my email' do
    visit "/"
    click_on "Register"
    expect(current_path).to eq("/register")
    fill_in :email, with: "zachholcombmusic@gmail.com"
    fill_in :first_name, with: 'Zach'
    fill_in :last_name, with: 'Apple'
    fill_in :password, with: '1234'
    fill_in :password_confirmation, with: '1234'
    click_on 'Create Account'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Logged in as zachholcombmusic@gmail.com')

    user = User.last
    expect(user.status).to eq('Pending')
    expect(page).to have_content('This account has not yet been activated. Please check your email.')

    visit '/user/activate'
    expect(page).to have_content("Thank you! Your account is now activated.")

    visit '/dashboard'
    expect(page).to have_content('Status: Active')
  end
end