require 'auth_controller'
require 'tzinfo'

require './lib/calendar/GoogleCalendar'

class PanelsController < ApplicationController
  before_filter AuthFilter

  @@tz = TZInfo::Timezone.get('America/Los_Angeles').current_period

  class NewHelper
    def initialize(session, start_time, end_time, pool_id = 0)
      @session = session
      @start_time = start_time
      @end_time = end_time
      @pool_id = pool_id
    end
    
    attr_accessor :session, :start_time, :end_time, :panel_name, :pool_id
  end
    
  # GET /panels
  # GET /panels.json
  def index
    @panels = Panel.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @panels }
    end
  end

  # GET /panels/1
  # GET /panels/1.json
  def show
    @panel = Panel.find(params[:id])
    @tz = @@tz
    
    cal = GoogleCalendar.new(AuthController.gclient)
    scheduler = InterviewerScheduler.new(cal)
    @panel.sessions.each {|s| scheduler.update_status(s)}
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @panel }
    end
  end

  #helper :all
  # GET /panels/new
  # GET /panels/new.json
  def new
    @panel = Panel.new
    
    starts = [10, 11, 13, 14, 15]
    @sessions = []
    for st in starts      
      s = @panel.sessions.new(:panel => @panel,
                              :state => Session::UNSCHEDULED)
      @sessions << NewHelper.new(s, st, st + 1)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @panel }
    end
  end

  # GET /panels/1/edit
  def edit
    @panel = Panel.find(params[:id])
  end
  
  # POST /panels
  # POST /panels.json
  def create
    @panel = Panel.new(params[:panel])

    @sessions = []
    sessions = []
    sessionsParams = params[:session]
    (0...sessionsParams.size).each do |i|
      sessionParams = sessionsParams[i.to_s]
      pool = InterviewerPool.find(sessionParams[:pool_id])
      
      tz_s = @@tz.abbreviation.to_s
      sstart = DateTime.new(@panel.date.year, @panel.date.mon, @panel.date.mday, sessionParams[:start].to_i, 0, 0, tz_s)
      send = DateTime.new(@panel.date.year, @panel.date.mon, @panel.date.mday, sessionParams[:end].to_i, 0, 0, tz_s)
      s = @panel.sessions.new(:panel => @panel,
                              :interviewer_pool => pool,
                              :start => sstart,
                              :end => send,
                              :state => Session::UNSCHEDULED)
      @sessions << NewHelper.new(s, sstart.hour, send.hour, pool.id)
    end
    
    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @panel.sessions.each do |s|
            cal = GoogleCalendar.new(AuthController.gclient)
            InterviewerScheduler.new(cal).schedule(s)
          end
          
          @panel.save!
        end
      end
    
      if @panel.save
        format.html { redirect_to @panel, :notice => 'Panel was successfully created.' }
        format.json { render :json => @panel, :status => :created, :location => @panel }
      else
        format.html { render :action => "new" }
        format.json { render :json => @panel.errors, :status => :unprocessable_entity }
      end
    end
  end

# update/destroy not yet supported
=begin
  # PUT /panels/1
  # PUT /panels/1.json
  def update
    @panel = Panel.find(params[:id])

    respond_to do |format|
      if @panel.update_attributes(params[:panel])
        format.html { redirect_to @panel, :notice => 'Panel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @panel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panels/1
  # DELETE /panels/1.json
  def destroy
    @panel = Panel.find(params[:id])
    @panel.destroy

    respond_to do |format|
      format.html { redirect_to panels_url }
      format.json { head :no_content }
    end
  end
=end
end
