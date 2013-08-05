class CtimesController < ApplicationController
  # GET /ctimes
  # GET /ctimes.json
  def index
    @ctimes = Ctime.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ctimes }
    end
  end

  # GET /ctimes/1
  # GET /ctimes/1.json
  def show
    @ctime = Ctime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ctime }
    end
  end

  # GET /ctimes/new
  # GET /ctimes/new.json
  def new
    @ctime = Ctime.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ctime }
    end
  end

  # GET /ctimes/1/edit
  def edit
    @ctime = Ctime.find(params[:id])
  end

  # POST /ctimes
  # POST /ctimes.json
  def create
    @ctime = Ctime.new(params[:ctime])

    respond_to do |format|
      if @ctime.save
        format.html { redirect_to @ctime, notice: 'Ctime was successfully created.' }
        format.json { render json: @ctime, status: :created, location: @ctime }
      else
        format.html { render action: "new" }
        format.json { render json: @ctime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ctimes/1
  # PUT /ctimes/1.json
  def update
    @ctime = Ctime.find(params[:id])

    respond_to do |format|
      if @ctime.update_attributes(params[:ctime])
        format.html { redirect_to @ctime, notice: 'Ctime was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ctime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ctimes/1
  # DELETE /ctimes/1.json
  def destroy
    @ctime = Ctime.find(params[:id])
    @ctime.destroy

    respond_to do |format|
      format.html { redirect_to ctimes_url }
      format.json { head :no_content }
    end
  end
end
