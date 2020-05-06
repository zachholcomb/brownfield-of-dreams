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
end