require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  scenario "deleting tutorial also removes its videos" do
    admin = create(:admin)
    tutorial = create(:tutorial)
    tutorial.videos.create!({
      "title"=>"Flow Control in Ruby",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"tZDBWXZzLPk",
      "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
      "position"=>1
    })
    
    expect(Video.all.length).to eq(1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 1)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end
    
    expect(Video.all.length).to eq(0)
  end
end
