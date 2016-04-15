class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter :authenticate_user!

  private  
  def mobile?  
    (request.user_agent =~ /Mobile|webOS/).nil?
  end

  helper_method :mobile?
end
