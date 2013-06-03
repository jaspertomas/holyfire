class BatchesController < ApplicationController
  # GET /batches
  # GET /batches.json
  def index
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin 
    @batches = Batch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @batches }
    end
  end

  # GET /batches/1
  # GET /batches/1.json
  def show
    @batch = Batch.find(params[:id])
    @gender = params[:gender]
    @gender="Both" if @gender==nil
    @sort = params[:sort]
    @sort="id" if @sort==nil
    @order = params[:order]
    @order="normal" if @order==nil
    cookies.permanent[:gender] = @gender

      
    @participants=@batch.blessing.participants
    if @sort=='no'
      @participants.sort! { |a,b| a.no <=> b.no }
    elsif @sort=='name'
      @participants.sort! { |a,b| a.name <=> b.name }
    elsif @sort=='sex'
      @participants.sort! { |a,b| a.sex <=> b.sex }
    elsif @sort=='age'
      @participants.sort! { |a,b| a.age <=> b.age }
    elsif @sort=='donation'
      @participants.sort! { |a,b| a.donation <=> b.donation }
    end
    
    if @order=='reverse'
      @participants=@participants.reverse
    end    
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @batch }
      format.csv { render text: @batch.to_csv }
    end
  end

  # GET /batches/new
  # GET /batches/new.json
  def new
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.new
    @batch.blessing_id=params[:blessing_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @batch }
    end
  end

  # GET /batches/1/edit
  def edit
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
  end

  # POST /batches
  # POST /batches.json
  def create
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.new(params[:batch])

    respond_to do |format|
      if @batch.save
        format.html { redirect_to @batch.blessing, notice: 'Batch was successfully created.' }
        format.json { render json: @batch, status: :created, location: @batch }
      else
        format.html { render action: "new" }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /batches/1
  # PUT /batches/1.json
  def update
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])

    respond_to do |format|
      if @batch.update_attributes(params[:batch])
        format.html { redirect_to @batch.blessing, notice: 'Batch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1
  # DELETE /batches/1.json
  def destroy
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to @batch.blessing }
      format.json { head :no_content }
    end
  end


  def addparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    @participant=Participant.find(params[:participant_id])      
    
    @participant.update_attributes(batch_id: @batch.id)  
      
    flash[:success] = "Participant "+@participant.to_s+" successfully added to "+@batch.to_s

    redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
  end    
  def removeparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    @participant=Participant.find(params[:participant_id])      
    
    @participant.update_attributes(batch_id: nil)  
      
    flash[:success] = "Participant "+@participant.to_s+" successfully removed from "+@batch.to_s

    redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
  end    
  def finalizeparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    @participant=Participant.find(params[:participant_id])      
    @participant.update_attributes(is_finalized: true)  
    flash[:success] = "Participant "+@participant.to_s+" successfully finalized to "+@batch.to_s
    redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
  end 
  def massaddparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    
    if params[:participant_ids].nil?
      flash[:error] = "0 participants selected"
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
      return 
    end
    
    Participant.update_all(["batch_id=?",@batch.id], :id=>params[:participant_ids])
    flash[:success] = params[:participant_ids].count.to_s+" participant"+(params[:participant_ids].count>1 ? "s" : "" )+" successfully added to "+@batch.to_s
    redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
  end 
  def massprocessparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])

    if params[:participant_ids].nil?
      flash[:error] = "0 participants selected"
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
      return 
    end
    
    if params[:commit]=="Remove Multiple Participants"
      Participant.update_all(["batch_id=?",nil], :id=>params[:participant_ids])
      flash[:success] = " participant "+@participant.to_s+" successfully removed from "+@batch.to_s
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
    elsif params[:commit]=="Move Multiple Participants to"
      Participant.update_all(["batch_id=?",params[:movetobatch_id]], :id=>params[:participant_ids])
      flash[:success] = "Participant "+@participant.to_s+" successfully removed from "+@batch.to_s
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
    elsif params[:commit]=="Finalize Multiple Participants"
      Participant.update_all(["is_finalized=?",true], :id=>params[:participant_ids])
      flash[:success] = "Participant "+@participant.to_s+" successfully finalized to "+@batch.to_s
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:params[:gender]
    end
  end 


  def error
    @title=params[:title]
    @message=params[:message]
    @redirectto=params[:redirectto]
  end  
end

