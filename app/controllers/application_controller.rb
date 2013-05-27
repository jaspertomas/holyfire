class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include SentientController
 
  before_filter :require_login
  
  private
  
#  def require_login
#    unless current_user || (params[:controller]=="sessions") 
#      redirect_to new_session_url
#    end
#  end  

  def require_login
    if Setting.all.empty?
      Setting.create(name: "currentblessing", value: 0, datatype: "Blessing")
    end
    
    #if user table is empty, force create admin user account
    if User.all.empty? 
      #if users/new or users/create, let it pass
      if !(params[:controller]=="users" && (params[:action]=="new" || params[:action]=="create")) 
        return redirect_to new_user_url
      end
      #if blessing table is empty, force create first blessing
    elsif Blessing.all.empty? 
      #if blessings/new or blessings/create, let it pass
      if !(params[:controller]=="blessings" && (params[:action]=="new" || params[:action]=="create")) 
        flash[:success] = "Please create your first Blessing event"
        return redirect_to new_blessing_url
      end
    #else if not logged in and not trying to login, redirect to login
    elsif !current_user 
      if !(params[:controller]=="sessions") 
        return redirect_to new_session_url
      end
    end
  end
end

