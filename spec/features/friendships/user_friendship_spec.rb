require 'rails_helper'

describe 'As a registered user' do
  scenario 'I can add friends to my account' do
    user_params = { email: 'zachholcombmusic@gmail.com',
                    first_name: 'Zach',
                    last_name: 'Holcomb',
                    password: '1234',
                    role: 0,
                    github_user: 'zachholcomb',
                    token: ENV['GITHUB_TOKEN1']
    }

   user_params2 = { email: 'byrdlike@gmail.com',
                    first_name: 'Zach',
                    last_name: 'Holcomb',
                    password: '1234',
                    role: 0,
                    github_user: 'apple342',
                    token: ENV['GITHUB_TOKEN2']
    }

    user = User.create!(user_params)
    user2 = User.create!(user_params2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit '/dashboard'

    within ".followers" do
      expect(page).to have_content('apple342')
      click_on 'Add Friend'
    end
    
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Added friend')
    within ".friends" do
      expect(page).to have_content('apple342')
    end
  end
end