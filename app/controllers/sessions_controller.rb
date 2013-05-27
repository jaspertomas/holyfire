class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_name(params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      flash.now[:success] = 'Login successful'
      sign_in user
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  def destroy
    sign_out
    redirect_to root_url
  end
end
