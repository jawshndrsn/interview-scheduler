require 'google/api_client'

class AuthFilter
  def self.filter(controller)
    unless AuthController.authorized
      controller.flash[:error] = "You must authorize use of your calendar first"
      controller.redirect_to controller.new_auth_url
    end
  end
end

class AuthController < ApplicationController
  def self.create_google_client
    gc = Google::APIClient.new
    gc.authorization.client_id = OAUTH_CONFIG[:google][:client_id]
    gc.authorization.client_secret = OAUTH_CONFIG[:google][:client_secret]
    gc.authorization.scope = OAUTH_CONFIG[:google][:scope]
    gc.authorization.redirect_uri = OAUTH_CONFIG[:google][:redirect_uri]
    gc
  end
  
  @@gclient = create_google_client
  @@authorized = false

  class << self
    #attr_reader doesn't work here - class variables lose values set earlier
    #attr_reader :gclient, :authorized
    
    def authorized
      return @@authorized
    end
    
    def gclient
      return @@gclient
    end
  end

  def index
    #redirect_to auth_authorize_path
    
    respond_to do |format|
      format.html # index.html.erb
      #format.json { render :json => @panels }
    end
  end
  
  def new
    # this improperly assumes @@gclient is initialized.
    @authorization_uri = @@gclient.authorization.authorization_uri
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def create
    auth_code = params[:auth_code]
    
    @@authorized = false
    @@gclient.authorization.code = auth_code
    
    # this could throw a big mess of an exception, so deal with it more cleanly in the future
    @@gclient.authorization.fetch_access_token!
    
    @@authorized = true
    
    redirect_to auth_index_path
  end
end
