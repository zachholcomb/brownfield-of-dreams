require 'rails_helper'

describe "An admin visting create new tutorials page" do
  let(:admin) { create(:admin) }

  scenario "can create a new tutorial with correct information" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in 'tutorial[title]', with: "How to Play Piano"
    fill_in 'tutorial[description]', with: "In these videos, I teach you how to play basic scales."
    fill_in 'tutorial[thumbnail]', with: "https://i.ytimg.com/vi/yfDJ-OAIADo/hqdefault.jpg?sqp=-oaymwEZCNACELwBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLALlh19sNew-eYkQpHTvtnCdhdgXg"
    click_on 'Save'

    expect(Tutorial.count).to eq(1)
    new_tutorial = Tutorial.last

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Successfully created tutorial. View it here.")
    click_on "View it here."
    expect(current_path).to eq("/tutorials/#{new_tutorial.id}")
  end

  scenario "cannot create a new tutorial without correct information" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in 'tutorial[title]', with: ""
    fill_in 'tutorial[description]', with: "In these videos, I teach you how to play basic scales."
    fill_in 'tutorial[thumbnail]', with: 9
    click_on 'Save'
    expect(page).to have_content("Tutorial not created: Title can't be blank and Thumbnail must be a valid URL")
    expect(find_field('Description').value).to eq "In these videos, I teach you how to play basic scales."
  end
end

