class ParticipantsController < ApplicationController
  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participants }
    end
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    @participant = Participant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /participants/new
  # GET /participants/new.json
  def new
    #admin and encoder only
    return redirect_to static_pages_encoderonlyerror_path if !current_user.is_admin && !current_user.is_encoder
    @participant = Participant.new
    @participant.blessing_id=params[:blessing_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /participants/1/edit
  def edit
    #admin and encoder only
    return redirect_to static_pages_encoderonlyerror_path if !current_user.is_admin && !current_user.is_encoder
    @participant = Participant.find(params[:id])
  end

  # POST /participants
  # POST /participants.json
  def create
    #admin and encoder only
    return redirect_to static_pages_encoderonlyerror_path if !current_user.is_admin && !current_user.is_encoder
    @participant = Participant.new(params[:participant])

    respond_to do |format|
      if @participant.save
        flash[:success] = "Participant "+@participant.name+" was successfully created."
        if params[:commit]=="Create participant and add another"
          format.html { redirect_to action:"new", controller:"participants", blessing_id: @participant.blessing_id, notice: 'Participant was successfully created.' }
          format.json { render json: @participant, status: :created, location: @participant }
        elsif
          format.html { redirect_to @participant.blessing, notice: 'Participant was successfully created.' }
          format.json { render json: @participant, status: :created, location: @participant }
        end
        
        
      else
        format.html { render action: "new" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participants/1
  # PUT /participants/1.json
  def update
    #admin and encoder only
    return redirect_to static_pages_encoderonlyerror_path if !current_user.is_admin && !current_user.is_encoder
    @participant = Participant.find(params[:id])

    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        format.html do
          if @participant.batch_id!=nil 
            redirect_to controller:"batches", action: "show", id: @participant.batch.id, gender:@participant.sex
          else
            redirect_to @participant.blessing, notice: 'Participant was successfully updated.' 
          end
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    #admin and encoder only
    return redirect_to static_pages_encoderonlyerror_path if !current_user.is_admin && !current_user.is_encoder
    @participant = Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to @participant.blessing }
      format.json { head :no_content }
    end
  end

  def finalize
    #admin and encoder only
    return redirect_to static_pages_encoderonlyerror_path if !current_user.is_admin && !current_user.is_encoder
    @participant = Participant.find(params[:id])
    @participant.update_attributes(finalized_id:1)

    respond_to do |format|
      format.html { redirect_to controller:"batches", action: "show", id: @batch.id, gender:@participant.sex }
      format.json { head :no_content }
    end
  end


end
