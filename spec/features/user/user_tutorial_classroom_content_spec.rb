require 'rails_helper'

describe "A logged in user" do
  before(:each) do
    mod_3_tutorial_data = {
      "title"=>"Back End Engineering - Module 3",
      "description"=>"Video content for Mod 3.",
      "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
      "classroom"=>true,
      "tag_list"=>["Internet", "BDD", "Ruby"],
      }
    @m3_tutorial = Tutorial.create! mod_3_tutorial_data

    mod_2_tutorial_data = {
      "title"=>"Back End Engineering - Module 2",
      "description"=>"Video content for Mod 3.",
      "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
      "classroom"=>false,
      "tag_list"=>["Internet", "BDD", "Ruby"],
      }
    @m2_tutorial = Tutorial.create! mod_2_tutorial_data
  end
  scenario "cannot see tutorial classroom content when not logged in" do
    visit "/"
    expect(page).to have_link(@m2_tutorial.title)
    expect(page).to_not have_link(@m3_tutorial.title)
  end

  scenario "can see tutorials that are classroom content when logged in" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/"
    expect(page).to have_link(@m2_tutorial.title)
    expect(page).to have_link(@m3_tutorial.title)
  end
end