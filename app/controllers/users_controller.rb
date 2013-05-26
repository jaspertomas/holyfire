class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    params[:user][:is_admin]= params[:user].has_key?("is_admin") ? 1 : 0
    params[:user][:is_encoder]= params[:user].has_key?("is_encoder") ? 1 : 0
    params[:user][:is_batcher]= params[:user].has_key?("is_batcher") ? 1 : 0
    
    #if first user, enforce is admin 
    if User.all.empty?
      params[:user][:is_admin]=1
      params[:user][:is_encoder]=1
      params[:user][:is_batcher]=1
    end

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user        
#        flash[:success] = "Login successful!"        
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    params[:user][:is_admin]= params[:user].has_key?("is_admin") ? 1 : 0
    params[:user][:is_encoder]= params[:user].has_key?("is_encoder") ? 1 : 0
    params[:user][:is_batcher]= params[:user].has_key?("is_batcher") ? 1 : 0
    
    
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
