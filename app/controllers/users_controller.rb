class UsersController < ApplicationController
  def show
    return nil unless current_user.token

    render locals: {
      search_results: SearchResults.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{params[:email]}"
      flash[:notice] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    token = auth_hash['credentials']['token']
    github_user = auth_hash['info']['nickname']
    github_id = auth_hash['uid'].to_i
    current_user.update(
      token: token, github_user: github_user, github_id: github_id
    )
    current_user.save
    redirect_to dashboard_path
  end

  private

  def user_params
    params.permit(
      :email, :first_name, :last_name, :password, :password_confirmation
    )
  end

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end
end
