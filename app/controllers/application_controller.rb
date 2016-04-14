class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!

  private  
  def mobile?  
    (request.user_agent =~ /Mobile|webOS/).nil?
  end

  helper_method :mobile?
end
