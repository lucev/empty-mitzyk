class ApplicationController < ActionController::Base
  protect_from_forgery
  
 private  
 def mobile?  
   !(request.user_agent =~ /Mobile|webOS/).nil?
 end
 
 def opera_mini?
   !(request.user_agent =~ /Opera Mini/).nil?
 end

 helper_method :mobile?
 helper_method :opera_mini?
end
