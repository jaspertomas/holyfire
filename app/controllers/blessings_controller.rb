class BlessingsController < ApplicationController
  # GET /blessings
  # GET /blessings.json
  def index
    @blessings = Blessing.all
    @currentblessingsetting=Setting.find_by_name("currentblessing")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blessings }
    end
  end

  # GET /blessings/1
  # GET /blessings/1.json
  def show
    @blessing = Blessing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blessing }
    end
  end

  # GET /blessings/new
  # GET /blessings/new.json
  def new
    @blessing = Blessing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blessing }
    end
  end

  # GET /blessings/1/edit
  def edit
    @blessing = Blessing.find(params[:id])
  end

  # POST /blessings
  # POST /blessings.json
  def create
    @blessing = Blessing.new(params[:blessing])

    #parse date string to date
    begin
      params[:blessing][:date] = DateTime.strptime(params[:blessing][:datestring], "%m/%d/%Y")
    rescue ArgumentError
      params[:blessing][:date]=nil
    end    

    respond_to do |format|
      if @blessing.save
        @currentblessingsetting=Setting.find_by_name("currentblessing").update_attributes(value: @blessing.id)
        format.html { redirect_to @blessing, notice: 'Blessing was successfully created.' }
        format.json { render json: @blessing, status: :created, location: @blessing }
      else
        format.html { render action: "new" }
        format.json { render json: @blessing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blessings/1
  # PUT /blessings/1.json
  def update
    @blessing = Blessing.find(params[:id])

    #parse date string to date
    begin
      params[:blessing][:date] = DateTime.strptime(params[:blessing][:datestring], "%m/%d/%Y")
    rescue ArgumentError
      params[:blessing][:date]=nil
    end    
    
    
    respond_to do |format|
      if @blessing.update_attributes(params[:blessing])
        format.html { redirect_to @blessing, notice: 'Blessing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blessing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blessings/1
  # DELETE /blessings/1.json
  def destroy
    @blessing = Blessing.find(params[:id])
    @blessing.destroy

    respond_to do |format|
      format.html { redirect_to blessings_url }
      format.json { head :no_content }
    end
  end

  def set
    # @params=params
    @blessing = Blessing.find(params[:id])
    @setting=Setting.find_by_name("currentblessing")
    @setting.value=@blessing.id.to_s
    @result=@setting.save
    flash[:success] = "Current Blessing successfully changed to "+@blessing.location.to_s

    redirect_to blessings_url
    
  end    
  def addbatch
    # @params=params
    @blessing = Blessing.find(params[:id])
    maxbatchno=0
    
    @blessing.batches.each do |batch|
      if batch.no > maxbatchno
        maxbatchno=batch.no
      end
    end
    
    maxbatchno+=1
    
    Batch.create(no: maxbatchno, blessing_id: @blessing.id, gender:"M")
    Batch.create(no: maxbatchno, blessing_id: @blessing.id, gender:"F")
    
    flash[:success] = "Successfully created batch "+maxbatchno.to_s+" for "+@blessing.to_s

    redirect_to  @blessing
    
  end 
  def current
    # @params=params
    @currentblessingsetting=Setting.find_by_name("currentblessing")
    
    if @currentblessingsetting==nil
      Setting.create(name: "currentblessing", value: 0, datatype: "Blessing")
      flash[:success] = "Please create your first Blessing event"

      redirect_to new_blessings_path
    end
    
    @blessing = Blessing.find(@currentblessingsetting.value)
    redirect_to  @blessing
    
  end 
end
