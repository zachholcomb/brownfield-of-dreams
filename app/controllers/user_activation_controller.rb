class UserActivationController < ApplicationController
  before_action :require_user

  def new
    user = current_user
    user.status = 'Active'
    user.save
    flash[:notice] = "Status: #{current_user.status}"
  end

  private

  def require_user
    four_oh_four unless current_user
  end
end
