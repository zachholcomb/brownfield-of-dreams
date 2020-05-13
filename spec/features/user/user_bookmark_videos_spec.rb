require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it "can see bookmarked videos on user dashboard" do
    tutorial = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial2 = create(:tutorial, title: "How to Play Piano")

    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    video2 = create(:video, title: "How to Play Piano", tutorial: tutorial2, position: 2)
    video3 = create(:video, title: "How to Make a Mojito", tutorial: tutorial2, position: 1)
    video4 = create(:video, title: "Let's Count to 5", tutorial: tutorial2)

    user1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit "/tutorials/#{tutorial2.id}"
    click_on(video4.title)
    click_on("Bookmark")
    
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    visit "/tutorials/#{tutorial.id}"
    click_on 'Bookmark'

    visit "/tutorials/#{tutorial2.id}"
    click_on(video2.title)
    click_on("Bookmark")
    click_on(video3.title)
    click_on("Bookmark")

    visit '/dashboard'

    within ".bookmarked-segments" do
      expect(page).to have_content('Bookmarked Segments')
      expect(page).to have_content("#{video1.title} from #{tutorial.title}")
      expect(page).to have_content("#{video2.title} from #{tutorial2.title}")
      expect(page).to have_content("#{video3.title} from #{tutorial2.title}")
      expect(page).to_not have_content("#{video4.title} from #{tutorial2.title}")
      expect("#{video3.title} from #{tutorial2.title}").to appear_before("#{video2.title} from #{tutorial2.title}", only_text: true)
    end
  end
end
