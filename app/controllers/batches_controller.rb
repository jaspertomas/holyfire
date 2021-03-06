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
      format.csv { render text: Batch.to_csv }
      format.xls #{ render text: Batch.to_csv(col_sep: "\t") }
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
    elsif @sort=='introducer'
      @participants.sort! { |a,b| a.introducer <=> b.introducer }
    elsif @sort=='guarantor'
      @participants.sort! { |a,b| a.guarantor <=> b.guarantor }
      elsif @sort=='missionary'
        @participants.sort! { |a,b| a.missionary <=> b.missionary }

    else          
      @participants=@participants.sort_by{|x| [x.sex, x.donation, x.age ]}.reverse
    end
    
    if @order=='reverse'
      @participants=@participants.reverse
    end    
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @batch }
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
    #admin only
    return redirect_to static_pages_adminonlyerror_path if !current_user.is_admin
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
    
    current_user=User.find_by_remember_token(cookies[:remember_token])
    @participant.update_attributes(batch_id: @batch.id, batched_by_id:current_user.id )  
      
    flash[:success] = "Participant "+@participant.to_s+" successfully added to "+@batch.to_s

    redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
  end    
  def removeparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    @participant=Participant.find(params[:participant_id])      
    
    @participant.update_attributes(batch_id: nil)  
      
    flash[:success] = "Participant "+@participant.to_s+" successfully removed from "+@batch.to_s

    redirect_to controller:"batches", action: "show", id: @batch.id, gender: cookies[:gender]
  end    
  def finalizeparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    @participant=Participant.find(params[:participant_id])      
    @participant.update_attributes(is_finalized: true)  
    flash[:success] = "Participant "+@participant.to_s+" successfully finalized to "+@batch.to_s
    redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
  end 
  def unfinalizeparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    @participant=Participant.find(params[:participant_id])      
    @participant.update_attributes(is_finalized: false)  
    flash[:success] = "Participant "+@participant.to_s+" successfully unfinalized to "+@batch.to_s
    redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
  end 
  def massaddparticipant
    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])
    
    if params[:participant_ids].nil?
      flash[:error] = "0 participants selected"
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
      return 
    end
    
    Participant.update_all(["batch_id=?",@batch.id], :id=>params[:participant_ids])
    flash[:success] = params[:participant_ids].count.to_s+" participant"+(params[:participant_ids].count>1 ? "s" : "" )+" successfully added to "+@batch.to_s
    redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
  end 
  def massprocessparticipant

    #admin and batcher only
    return redirect_to static_pages_batcheronlyerror_path if !current_user.is_admin && !current_user.is_batcher
    @batch = Batch.find(params[:id])

    if params[:participant_ids].nil?
      flash[:error] = "0 participants selected"
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
      return 
    end
    
    if params[:commit]==["Remove Multiple Participants"]
      Participant.update_all(["batch_id=?",nil], :id=>params[:participant_ids])
      current_user=User.find_by_remember_token(cookies[:remember_token])
      Participant.update_all(["batched_by_id=?",current_user.id], :id=>params[:participant_ids])
      flash[:success] = params[:participant_ids].size.to_s+" participants successfully removed from "+@batch.to_s
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
    elsif params[:commit]==["Move Multiple Participants to"]
      Participant.update_all(["batch_id=?",params[:movetobatch_id]], :id=>params[:participant_ids])
      flash[:success] = params[:participant_ids].size.to_s+" participants successfully removed from "+@batch.to_s
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
    elsif params[:commit]==["Finalize Multiple Participants"]
      Participant.update_all(["is_finalized=?",true], :id=>params[:participant_ids])
      flash[:success] = params[:participant_ids].size.to_s+" participants successfully finalized to "+@batch.to_s
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
    elsif params[:commit]==["Set Introducer / Guarantor"]
      Participant.update_all(["introducer=?",params[:introducer][:introducer]], :id=>params[:participant_ids]) if !params[:introducer][:introducer].empty?
      Participant.update_all(["guarantor=?",params[:guarantor][:guarantor]], :id=>params[:participant_ids]) if !params[:guarantor][:guarantor].empty?
      Participant.update_all(["missionary=?",params[:missionary][:missionary]], :id=>params[:participant_ids]) if !params[:missionary][:missionary].empty?
      flash[:success] = "Successfully updated introducer / guarantor for "+params[:participant_ids].size.to_s+" participants"
      redirect_to controller:"batches", action: "show", id: @batch.id, gender:cookies[:gender]
#    elsif params[:commit]==["Print IDs"]
#      @participants=Participant.find_by_sql("select * from participants where id in (#{params[:participant_ids].join(', ')})")
#      
#      render :pdf => @batch.to_s+"ids.pdf", # pdf will download as my_pdf.pdf
#      :layout => 'empty', 
#      :show_as_html => params[:debug].present?, # renders html version if you set debug=true in URL
#     template: "batches/ids.pdf.erb"
    elsif params[:commit]==["IDs Front Page"]
      @participants=Participant.find_by_sql("select * from participants where id in (#{params[:participant_ids].join(', ')})")
      @temple=Setting.find_by_name("temple").value
      
      render :pdf => @batch.to_s+"idsfront.pdf", # pdf will download as my_pdf.pdf
      :layout => 'empty', 
      :show_as_html => params[:debug].present?, # renders html version if you set debug=true in URL
     template: "batches/idsfront.pdf.erb"
    elsif params[:commit]==["IDs Back Page"]
      @participants=Participant.find_by_sql("select * from participants where id in (#{params[:participant_ids].join(', ')})")
      @temple=Setting.find_by_name("temple").value
      
      render :pdf => @batch.to_s+"idsback.pdf", # pdf will download as my_pdf.pdf
      :layout => 'empty', 
      :show_as_html => params[:debug].present?, # renders html version if you set debug=true in URL
     template: "batches/idsback.pdf.erb"
    end
  end 

  def error
    @title=params[:title]
    @message=params[:message]
    @redirectto=params[:redirectto]
  end  
  def settime
    @batch = Batch.find(params[:id])
    @batch.update_attributes(ctime_id: params[:ctime_id][:ctime_id])
    flash[:success]="Successfully set batch blessing time to "+@batch.ctime.span
    redirect_to request.referer
  end  
end

