require 'rails_helper'

describe 'About show page' do
  scenario 'shows information' do
    visit '/about'
    expect(page).to have_content('Turing Tutorials')
  end
end