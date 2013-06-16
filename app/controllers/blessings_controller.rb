class BlessingsController < ApplicationController
  # GET /blessings
  # GET /blessings.json
  def index
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin 
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

    @sort = params[:sort]
    @sort="id" if @sort==nil
    @order = params[:order]
    @order="normal" if @order==nil
    #cookies.permanent[:gender] = @gender
        
      @participants=@blessing.participants
      if @sort=='no'
        @participants.sort! { |a,b| a.no <=> b.no }
      elsif @sort=='fname'
        @participants.sort! { |a,b| a.fname <=> b.fname }
      elsif @sort=='mname'
        @participants.sort! { |a,b| a.mname <=> b.mname }
      elsif @sort=='lname'
        @participants.sort! { |a,b| a.lname <=> b.lname }
      elsif @sort=='sex'
        @participants=@participants.sort_by{|x| [x.sex, x.donation, x.age ]}.reverse
      elsif @sort=='age'
        @participants=@participants.sort_by{|x| [x.age, x.donation ]}.reverse
      elsif @sort=='donation'
  #      @participants=@participants.sort_by{|x| [x.donation, x.age ]}.reverse
        @participants.sort! { |a,b| b.donation <=> a.donation }
  
      else          
        @participants=@participants.sort_by{|x| [x.sex, x.donation, x.age ]}.reverse
      end
      
      if @order=='reverse'
        @participants=@participants.reverse
      end    
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blessing }
#      format.csv
      format.xls

    end
  end

  # GET /blessings/new
  # GET /blessings/new.json
  def new
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
    @blessing = Blessing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blessing }
    end
  end

  # GET /blessings/1/edit
  def edit
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin 
    #return redirect_to controller:"static_pages", action:"error", title:"Access Denied", message:"Sorry, only administrators can access this"
    @blessing = Blessing.find(params[:id])
  end

  # POST /blessings
  # POST /blessings.json
  def create
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin 
    @blessing = Blessing.new(params[:blessing])

    #parse date string to date
#    begin
#      params[:blessing][:date] = DateTime.strptime(params[:blessing][:datestring], "%m/%d/%Y")
#    rescue ArgumentError
#      params[:blessing][:date]=nil
#    end    

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
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin 
    @blessing = Blessing.find(params[:id])

    #parse date string to date
#    begin
#      params[:blessing][:date] = DateTime.strptime(params[:blessing][:datestring], "%m/%d/%Y")
#    rescue ArgumentError
#      params[:blessing][:date]=nil
#    end    
    
    
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
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin 
    @blessing = Blessing.find(params[:id])
    @blessing.destroy

    respond_to do |format|
      format.html { redirect_to blessings_url }
      format.json { head :no_content }
    end
  end

  def set
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin 
    # @params=params
    @blessing = Blessing.find(params[:id])
    @setting=Setting.find_by_name("currentblessing")
    @setting.value=@blessing.id.to_s
    @result=@setting.save
    flash[:success] = "Current Blessing successfully changed to "+@blessing.location.to_s

    redirect_to blessings_url
    
  end    
  def addbatch
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @blessing = Blessing.find(params[:id])
    maxbatchno=0
    
    @blessing.batches.each do |batch|
      if batch.no > maxbatchno
        maxbatchno=batch.no
      end
    end
    
    maxbatchno+=1
    
    Batch.create(no: maxbatchno, blessing_id: @blessing.id, gender:"M")
#    Batch.create(no: maxbatchno, blessing_id: @blessing.id, gender:"F")
    
    flash[:success] = "Successfully created batch "+maxbatchno.to_s+" for "+@blessing.to_s

    redirect_to  @blessing
    
  end 
  
  #show current blessing - redirect from menu home link
  def current 
    #anybody can access
    @currentblessingsetting=Setting.find_by_name("currentblessing")
    
    if @currentblessingsetting==nil
      Setting.create(name: "currentblessing", value: 0, datatype: "Blessing")
      flash[:success] = "Please create your first Blessing event"

      redirect_to new_blessings_path
    end
    
    @blessing = Blessing.find(@currentblessingsetting.value)
    redirect_to  @blessing
    
  end 
  #not implemented yet
  def massdeleteparticipant
#    @batch = Batch.find(params[:id])
#    Participant.update_all(["batch_id=?",@batch.id], :id=>params[:participant_ids])
#    flash[:success] = "Participant "+@participant.to_s+" successfully added to "+@batch.to_s
#    redirect_to @batch    
  end     
  def report
    @blessing = Blessing.find(params[:id])

    @sort = params[:sort]
    @sort="id" if @sort==nil
    @order = params[:order]
    @order="normal" if @order==nil
    #cookies.permanent[:gender] = @gender
        
      @participants=@blessing.participants
      if @sort=='no'
        @participants.sort! { |a,b| a.no <=> b.no }
      elsif @sort=='fname'
        @participants.sort! { |a,b| a.fname <=> b.fname }
      elsif @sort=='mname'
        @participants.sort! { |a,b| a.mname <=> b.mname }
      elsif @sort=='lname'
        @participants.sort! { |a,b| a.lname <=> b.lname }
      elsif @sort=='sex'
        @participants=@participants.sort_by{|x| [x.sex, x.donation, x.age ]}.reverse
      elsif @sort=='age'
        @participants=@participants.sort_by{|x| [x.age, x.donation ]}.reverse
      elsif @sort=='donation'
  #      @participants=@participants.sort_by{|x| [x.donation, x.age ]}.reverse
        @participants.sort! { |a,b| b.donation <=> a.donation }
  
      else          
        @participants=@participants.sort_by{|x| [x.sex, x.donation, x.age ]}.reverse
      end
      
      if @order=='reverse'
        @participants=@participants.reverse
      end    
      
    respond_to do |format|
      format.html # show.html.erb
    end     
  end
end
