require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
    it { should have_many(:friendships)}
    it { should have_many(:friends).through(:friendships)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance_methods' do
    it "bookmarked_videos" do
      user = create(:user)      
      tutorial = create(:tutorial, title: "How to Tie Your Shoes")
      tutorial2 = create(:tutorial, title: "How to Play Piano")

      video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
      video2 = create(:video, title: "How to Play Piano", tutorial: tutorial2, position: 1)
      video3 = create(:video, title: "How to Make a Mojito", tutorial: tutorial2, position: 3)
      video4 = create(:video, title: "Let's Count to 5", tutorial: tutorial2, position: 2)
      UserVideo.create!(user: user, video: video1)
      UserVideo.create!(user: user, video: video3)
      UserVideo.create!(user: user, video: video4)
      expect(user.bookmarked_videos).to eq([video1, video4, video3])
    end

    it "friend_list" do
      user = create(:user) 
      user2 = create(:user) 
      user3 = create(:user) 
      Friendship.create(user_id: user.id, friend_id: user2.id)
      Friendship.create(user_id: user.id, friend_id: user3.id)
      expect(user.friend_list(user.id)).to eq([user2, user3])
    end
  end
end
