require "rails_helper"

RSpec.describe InviterMailer, type: :mailer do
  describe "invite" do
    it "renders the headers" do
      info = { inviter: 'Zach Holcomb', invitee: 'Demarcus Kirby' }
      email_address = 'kirbyDD@example.com'
      email = InviterMailer.invite(info, email_address)
      expect(email.from).to eq(['no-reply@brownfield-team.com'])
      expect(email.to).to eq(['kirbyDD@example.com'])
      expect(email.subject).to eq("#{info[:inviter]} wants you to join Turing Tutorials!")
    end

    it "renders the body" do
      info = { inviter: 'Zach Holcomb', invitee: 'Demarcus Kirby' }
      email_address = 'kirbyDD@example.com'
      email = InviterMailer.invite(info, email_address)
      expect(email.body.encoded).to match("Hello Demarcus Kirby")
    end
  end
end
