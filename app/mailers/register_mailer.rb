class RegisterMailer < ApplicationMailer
  def register(info, email)
    @account = info[:account]
    mail(to: email, subject: 'Register your Brownfield account!')
  end
end