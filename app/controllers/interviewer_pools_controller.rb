class InterviewerPoolsController < ApplicationController
  # GET /interviewer_pools
  # GET /interviewer_pools.json
  def index
    @interviewer_pools = InterviewerPool.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @interviewer_pools }
    end
  end

  # GET /interviewer_pools/1
  # GET /interviewer_pools/1.json
  def show
    @interviewer_pool = InterviewerPool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @interviewer_pool }
    end
  end

  # GET /interviewer_pools/new
  # GET /interviewer_pools/new.json
  def new
    @interviewer_pool = InterviewerPool.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @interviewer_pool }
    end
  end

  # GET /interviewer_pools/1/edit
  def edit
    @interviewer_pool = InterviewerPool.find(params[:id])
  end

  # POST /interviewer_pools
  # POST /interviewer_pools.json
  def create
    @interviewer_pool = InterviewerPool.new(params[:interviewer_pool])

    respond_to do |format|
      if @interviewer_pool.save
        format.html { redirect_to @interviewer_pool, :notice => 'Interviewer pool was successfully created.' }
        format.json { render :json => @interviewer_pool, :status => :created, :location => @interviewer_pool }
      else
        format.html { render :action => "new" }
        format.json { render :json => @interviewer_pool.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interviewer_pools/1
  # PUT /interviewer_pools/1.json
  def update
    @interviewer_pool = InterviewerPool.find(params[:id])

    respond_to do |format|
      if @interviewer_pool.update_attributes(params[:interviewer_pool])
        format.html { redirect_to @interviewer_pool, :notice => 'Interviewer pool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @interviewer_pool.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interviewer_pools/1
  # DELETE /interviewer_pools/1.json
  def destroy
    @interviewer_pool = InterviewerPool.find(params[:id])
    @interviewer_pool.destroy

    respond_to do |format|
      format.html { redirect_to interviewer_pools_url }
      format.json { head :no_content }
    end
  end
end
