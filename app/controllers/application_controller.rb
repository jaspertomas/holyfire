class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
 
  before_filter :require_login
  
  private
  
#  def require_login
#    unless current_user || (params[:controller]=="sessions") 
#      redirect_to new_session_url
#    end
#  end  

  def require_login
    
    #if user table is empty, force create admin user account
    if User.all.empty? && !(params[:controller]=="users") 
      redirect_to new_user_url
    #else if not logged in and not trying to login, redirect to login
    elsif !User.all.empty? && !current_user && !(params[:controller]=="sessions") 
      redirect_to new_session_url
    end
  end
end

