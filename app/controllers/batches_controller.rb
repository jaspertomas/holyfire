class BatchesController < ApplicationController
  # GET /batches
  # GET /batches.json
  def index
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @batch }
    end
  end

  # GET /batches/new
  # GET /batches/new.json
  def new
    @batch = Batch.new
    @batch.blessing_id=params[:blessing_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @batch }
    end
  end

  # GET /batches/1/edit
  def edit
    @batch = Batch.find(params[:id])
  end

  # POST /batches
  # POST /batches.json
  def create
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
    @batch = Batch.find(params[:id])
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to @batch.blessing }
      format.json { head :no_content }
    end
  end


  def addparticipant
    @batch = Batch.find(params[:id])
    @participant=Participant.find(params[:participant_id])      
    
    @participant.update_attributes(batch_id: @batch.id)  
      
    flash[:success] = "Participant "+@participant.to_s+" successfully added to "+@batch.to_s

    redirect_to @batch    
  end    
  def removeparticipant
    @batch = Batch.find(params[:id])
    @participant=Participant.find(params[:participant_id])      
    
    @participant.update_attributes(batch_id: nil)  
      
    flash[:success] = "Participant "+@participant.to_s+" successfully removed from "+@batch.to_s

    redirect_to @batch    
  end    
  def massaddparticipant
    @batch = Batch.find(params[:id])
    Participant.update_all(["batch_id=?",@batch.id], :id=>params[:participant_ids])
    flash[:success] = "Participant "+@participant.to_s+" successfully added to "+@batch.to_s
    redirect_to @batch    
  end 
  def massremoveparticipant
    if params[:commit]=="Remove Multiple Participants"
      @batch = Batch.find(params[:id])
      Participant.update_all(["batch_id=?",nil], :id=>params[:participant_ids])
      flash[:success] = "Participant "+@participant.to_s+" successfully removed from "+@batch.to_s
      redirect_to @batch    
    elsif params[:commit]=="Move Multiple Participants to"
      @batch = Batch.find(params[:id])
      Participant.update_all(["batch_id=?",params[:movetobatch_id]], :id=>params[:participant_ids])
      flash[:success] = "Participant "+@participant.to_s+" successfully removed from "+@batch.to_s
      redirect_to @batch    
    end
  end 
end
