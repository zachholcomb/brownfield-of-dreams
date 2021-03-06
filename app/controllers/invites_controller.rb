class InvitesController < ApplicationController
  def new; end

  def create
    gh_service = GithubService.new(current_user.token, current_user.github_user)
    Invite.create(invite_params)
    user_data = gh_service.get_user(params[:github_handle])
    invite_email_paths(user_data)
    redirect_to dashboard_path
  end

  private

  def invite_params
    params.permit(:github_handle)
  end

  def invite_email_paths(user_data)
    if !user_data[:email].nil?
      info = { inviter: current_user.github_user, invitee: user_data[:login] }
      InviterMailer.invite(info, user_data[:email]).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email
      address associated with their account."
    end
  end
end
