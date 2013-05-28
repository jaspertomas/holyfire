class StaticPagesController < ApplicationController
  def index
    @params=params
    @cookies=cookies
  end

  def help
  end

  def admin
  end

  def error
  end

  def adminonlyerror
  end

  def encoderonlyerror
  end

  def batcheronlyerror
  end

  def initdb
    @params=params
#    @participants=Participant.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
#    @participants=Participant.find_all_by_lowercasing_name(params[:search])

    @participants = Participant.find_all_by_lowercasing_name(params[:search]).page(1).per(1)
      
    flash[:success] = @participants.count.to_s+" results found"
 
  end
  
  def search
    @params=params
    @participants = Participant.find_all_by_lowercasing_name(params[:search]).page(params[:page]).per(30)
      
    flash[:success] = @participants.count.to_s+" results found"
 
  end     
end
