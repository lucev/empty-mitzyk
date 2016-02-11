class ApplicationController < ActionController::Base
  protect_from_forgery
  
 private  
 def mobile?  
   !(request.user_agent =~ /Mobile|webOS/).nil?
 end

 helper_method :mobile?
end
