class InterviewersController < ApplicationController
  # GET /interviewers
  # GET /interviewers.json
  def index
    @interviewers = Interviewer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @interviewers }
    end
  end

  # GET /interviewers/1
  # GET /interviewers/1.json
  def show
    @interviewer = Interviewer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @interviewer }
    end
  end

  # GET /interviewers/new
  # GET /interviewers/new.json
  def new
    @interviewer = Interviewer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @interviewer }
    end
  end

  # GET /interviewers/1/edit
  def edit
    @interviewer = Interviewer.find(params[:id])
  end

  # POST /interviewers
  # POST /interviewers.json
  def create
    @interviewer = Interviewer.new(params[:interviewer])

    respond_to do |format|
      if @interviewer.save
        format.html { redirect_to @interviewer, :notice => 'Interviewer was successfully created.' }
        format.json { render :json => @interviewer, :status => :created, :location => @interviewer }
      else
        format.html { render :action => "new" }
        format.json { render :json => @interviewer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interviewers/1
  # PUT /interviewers/1.json
  def update
    @interviewer = Interviewer.find(params[:id])

    respond_to do |format|
      if @interviewer.update_attributes(params[:interviewer])
        format.html { redirect_to @interviewer, :notice => 'Interviewer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @interviewer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interviewers/1
  # DELETE /interviewers/1.json
  def destroy
    @interviewer = Interviewer.find(params[:id])
    @interviewer.destroy

    respond_to do |format|
      format.html { redirect_to interviewers_url }
      format.json { head :no_content }
    end
  end
end
