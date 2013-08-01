class PastorsController < ApplicationController
  # GET /pastors
  # GET /pastors.json
  def index
    @pastors = Pastor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pastors }
    end
  end

  # GET /pastors/1
  # GET /pastors/1.json
  def show
    @pastor = Pastor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pastor }
    end
  end

  # GET /pastors/new
  # GET /pastors/new.json
  def new
    @pastor = Pastor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pastor }
    end
  end

  # GET /pastors/1/edit
  def edit
    @pastor = Pastor.find(params[:id])
  end

  # POST /pastors
  # POST /pastors.json
  def create
    @pastor = Pastor.new(params[:pastor])

    respond_to do |format|
      if @pastor.save
        format.html { redirect_to @pastor, notice: 'Pastor was successfully created.' }
        format.json { render json: @pastor, status: :created, location: @pastor }
      else
        format.html { render action: "new" }
        format.json { render json: @pastor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pastors/1
  # PUT /pastors/1.json
  def update
    @pastor = Pastor.find(params[:id])

    respond_to do |format|
      if @pastor.update_attributes(params[:pastor])
        format.html { redirect_to @pastor, notice: 'Pastor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pastor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pastors/1
  # DELETE /pastors/1.json
  def destroy
    @pastor = Pastor.find(params[:id])
    @pastor.destroy

    respond_to do |format|
      format.html { redirect_to pastors_url }
      format.json { head :no_content }
    end
  end
end
