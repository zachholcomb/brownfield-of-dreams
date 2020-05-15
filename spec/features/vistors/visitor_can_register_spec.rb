require 'rails_helper'

describe 'vister can create an account', :js do
  it ' visits the home page' do
    email = 'jimbob2@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in :email, with: email
    fill_in :first_name, with: first_name
    fill_in :last_name, with: last_name
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
  end

  it 'only with a unique email' do
    email = 'jimbob2@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    user = User.create!(email: email, 
                        first_name: 'Zach',
                        last_name: 'H',
                        password: '1234',
                        password_confirmation: '1234'
    )
    visit '/register'

    fill_in :email, with: email
    fill_in :first_name, with: first_name
    fill_in :last_name, with: last_name
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on'Create Account'

    expect(page).to have_content('Username already exists')
  end
end
