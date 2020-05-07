require 'rails_helper'

describe "An admin visiting create new tutorials page" do
  scenario "can see a link to import new Youtube Playlist" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"
    expect(page).to have_link("Import Youtube Playlist") 
  end

  scenario "can lick a link to import new Youtube Playlist and see a form to add a new playlist" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    click_link "Import Youtube Playlist"
    fill_in "Playlist", with: "PLLNZ36qP29I7xrabeFtg184WiEQl0QS6_"
  end

  scenario "can add a playlist id and is taken back to his dashboard and sees a flash message that the tutorial was successfully created" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"
    fill_in 'tutorial[title]', with: "How to Play Piano"
    fill_in 'tutorial[description]', with: "In these videos, I teach you how to play basic scales."
    fill_in 'tutorial[thumbnail]', with: "https://i.ytimg.com/vi/yfDJ-OAIADo/hqdefault.jpg?sqp=-oaymwEZCNACELwBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLALlh19sNew-eYkQpHTvtnCdhdgXg"
  
    click_link "Import Youtube Playlist"
    fill_in "Playlist", with: "PLLNZ36qP29I7xrabeFtg184WiEQl0QS6_"

    click_on 'Save'
    expect(Tutorial.count).to eq(1)
    new_tutorial = Tutorial.last

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content('Successfully created tutorial.')

    click_link 'View it here.'
    expect(current_path).to eq("/tutorials/#{new_tutorial.id}")

    expect(first(".show-link")).to eq("Synth Wizards Trailer")
    expect(last(".show-link").to eq("Synth Wizards Episode 9: Holy Grail: The Yamaha CS-80"))

    within ".title-bookmark" do
      expect(page).to have_content("Synth Wizards Trailer")
    end
  end
end