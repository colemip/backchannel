class LoginController < ApplicationController
  #before_filter :require_login, :except => :login
  before_filter :require_admin, :only => :admin_index
  layout 'application'
  
  def index
    
  end
  
  def admin_index
    
  end
  
  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def login
    #session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:login], params[:pw])
      if user #!= nil  
        flash[:notice] = "Welcome, #{user.first_name}!"      
        session[:user_id] = user.id
        session[:admin] = nil
        
        if user.admin?
          session[:admin] = true 
          redirect_to(:controller => "login", :action => "admin_index")            
        else          
          uri = session[:original_uri]
          session[:original_uri] = nil
          redirect_to(uri || {:controller => "posts", :action => "index"})    
        end    
      else
        flash.now[:notice] = "Invalid username/password combination"  
#        format.html { render :action => "login" }
      end
    end
  end
    
#  def logout
#    
#  end
    

  
  def create_account
    @user = User.new
    redirect_after_login(:login, :pw)

#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @user }
#    end
    
  end
  
  def redirect_after_login(login, pw)
    #session[:user_id] = nil
    if request.post?
      user = User.authenticate(login, pw)
      if user #!= nil  
        flash[:notice] = "Welcome, #{user.first_name}!"      
        session[:user_id] = user.id
#        uri = session[:original_uri]
#        session[:original_uri] = nil
        redirect_to(:controller => "posts", :action => "index")
        red
#      else
#        flash[:notice] = "Invalid username/password combination"         
      end
    end
  end
  
  def authorize(name, password)
    #logger.debug "TESTING"
    User.find_by_id(session[:user_id])
    flash[:notice] = "Please login"
    redirect_to(:controller => "login", :action => "login")
  end
  
  def search
    if request.get?      
      @users = Array.new
      
      User.find(:all, :conditions => ['login LIKE ?', params[:search]]).each do |user|
        @users << user
      end
      User.find(:all, :conditions => ['first_name LIKE ?', params[:search]]).each do |user|
        @users << user
      end
      User.find(:all, :conditions => ['last_name LIKE ?', params[:search]]).each do |user|
        @users << user
      end
      
      @posts = Array.new
      @users.each do |user|
        Post.find(:all, :conditions => ["user_id = #{user.id}"]).each do |post|
          @posts << post
        end
      end
                        
#      Post.find(:all, :conditions => ['title REGEXP %#{params[:search]}%']).each do |post|
#        @posts << post
#      end
#      Post.find(:all, :conditions => ['body LIKE %#{params[:search]}%']).each do |post|
#        @posts << post
#      end      
    end
    
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @user }
#    end
  end
  
#  def authenticate
#    
#  end
end