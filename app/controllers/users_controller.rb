class UsersController < ApplicationController
  before_action :authenticate_user!
  

  def settings
    @user = current_user
  end
  
  def set_limits
    if current_user.update_attributes(user_params)
      redirect_to root_path, notice: "Limits successfully set"
    else
      render action: "limit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:weekly_limit, :monthly_limit,
                                 :default_currency)
  end
end
