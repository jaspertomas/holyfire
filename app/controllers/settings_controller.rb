class SettingsController < ApplicationController
  # GET /settings
  # GET /settings.json
  def index
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @settings = Setting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @settings }
    end
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @setting = Setting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @setting }
    end
  end

  # GET /settings/new
  # GET /settings/new.json
  def new
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @setting = Setting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @setting }
    end
  end

  # GET /settings/1/edit
  def edit
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @setting = Setting.find(params[:id])
  end

  # POST /settings
  # POST /settings.json
  def create
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @setting = Setting.new(params[:setting])

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render json: @setting, status: :created, location: @setting }
      else
        format.html { render action: "new" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /settings/1
  # PUT /settings/1.json
  def update
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @setting = Setting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to settings_url }
      format.json { head :no_content }
    end
  end
end
