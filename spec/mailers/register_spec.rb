require "rails_helper"

RSpec.describe RegisterMailer, type: :mailer do
  describe "invite" do
    it "renders the headers" do
      info = { register: 'Zach Holcomb' }
      email_address = 'zachholcombmusic@gmail.com'
      email = RegisterMailer.register(info, email_address)
      expect(email.from).to eq(['no-reply@brownfield-team.com'])
      expect(email.to).to eq(['zachholcombmusic@gmail.com'])
      expect(email.subject).to eq("Register your Brownfield account!")
    end

    it "renders the body" do
      info = { register: 'Zach Holcomb' }
      email_address = 'zachholcombmusic@gmail.com'
      email = RegisterMailer.register(info, email_address)
    end
  end
end
