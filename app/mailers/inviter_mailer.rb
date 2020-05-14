class InviterMailer < ApplicationMailer
  def invite(info, email)
    @inviter = info[:inviter]
    @invitee = info[:invitee]
    mail(to: email, subject: "#{@inviter} wants you to join Turing Tutorials!")
  end
end
