class UsersController < ApplicationController
  before_filter :authenticate_user!
  

  def limits
    @user = current_user
  end
  
  def set_limits
    current_user.weekly_limit = params[:user][:weekly_limit] unless params[:user][:weekly_limit].nil?
    current_user.monthly_limit = params[:user][:monthly_limit] unless params[:user][:monthly_limit].nil?
    
    if current_user.save
      redirect_to root_path
      flash[:notice] = "Limits successfully set"
    end
  end
  
end
