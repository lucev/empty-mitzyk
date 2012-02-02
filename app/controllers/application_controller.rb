class ApplicationController < ActionController::Base
  protect_from_forgery
  
 private  
 def mobile?  
   request.user_agent =~ /Mini|Mobile|webOS/  
 end 

 helper_method :mobile?
end
