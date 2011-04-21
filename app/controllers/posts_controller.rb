class PostsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin, :except => [:index, :show, :new, :create, :add_cheer, :edit, :delete_cheer, :get_cheer_for_user_post, :add_response, :view_responses]
  layout 'application'
  # GET /posts
  # GET /posts.xml
  def index    
    @posts = Post.find(:all, :conditions => "response_id IS NULL OR response_id <= 0") # TODO put newest first
    @search_string = ""
    @user_id_in_session = session[:user_id]          
#    @cheer = Cheer.find_by
    
#    @posts = @posts.select do |post|                  
#      #@cheer_id = get_cheer_for_user_post(@user_id_in_session, post.id).id
#      # Only return posts that are not responses
##      @cheer = get_cheer_for_user_post(@user_id_in_session, post.id)
#      #@block = lambda{ Cheer.find_by_user_id_and_post_id(@user_id_in_session, post.id) }
#      post.response_id == nil || post.response_id <= 0      
#    end
    
#      @cheer = get_cheer_for_user_post(0,0)
#    if @posts
#      @posts.each do |post|
#        @cheers << get_cheer_for_user_post(@user_id_in_session, post.id)  
#      end
#    end
        
          
    #@cheer = get_cheer_for_user_post(post.user_id, post.id)
           
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  def get_user(user_id)
    @user = User.find(user_id)
    @user
  end


  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if (!session[:admin] && params[:id] != session[:user_id])  
      flash[:notice] = "Cannot edit a response that you did not post."
      redirect_to(:controller => "posts", :action => "index")
    end
  end

  # POST /posts
  # POST /posts.xml
  def create    
    @user_id_in_session = session[:user_id]            
    @post = Post.new(:title => params[:post]["title"], :body => params[:post]["body"], :user_id => @user_id_in_session)

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
 
 
  def add_cheer
    @user_id_in_session = session[:user_id]
    @cheer = Cheer.create(:user_id => @user_id_in_session, :post_id => params[:post_id] )
    
    respond_to do |format|
      if @cheer.save
        format.html { redirect_to(posts_url, :notice => 'Cheers!') }
        format.xml  { render :xml => @cheer, :status => :created, :location => @cheer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cheer.errors, :status => :unprocessable_entity }
      end
    end   
  end
  
  def delete_cheer
    @post_id = params[:post_id]
    @user_id = session[:user_id]
    @cheer = Cheer.find_by_post_id_and_user_id(@post_id, @user_id)
    @cheer.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  def get_cheer_for_user_post(user_id, post_id)
    #@cheer = Cheer.where(:user_id => user_id, :post_id => post_id)
    @cheer = Cheer.find_by_user_id_and_post_id(user_id, post_id)
    @cheer    
  end

  def add_response
    if request.get?
      @user_id_in_session = session[:user_id]  
      @post = Post.find(params[:id])
      #params[:user_id] = @user_id_in_session
      #@post = Post.new(params[:post])
      @response = Post.create(:title => params[:post]["title"], :body => params[:post]["body"], :user_id => @user_id_in_session, :response_id => params[:id])
  
      respond_to do |format|
        if @response.save
#          format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
#          format.xml  { render :xml => @post, :status => :created, :location => @post }
        else
#          format.html { render :action => "new" }
#          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        end
      end
    end
    
  end

  def view_responses_OLD(post_id)
    #@post_id = params[:post_id]
    #@responses = Post.find_by_response_id(@post_id)
#    if request.post?
      @responses = Post.find(:all, :conditions => ["response_id = #{post_id}"  ])
#    end
    
#    @responses = @responses.select do |response|                  
#      # Only return posts that are responses
#      response.response_id != nil   
#    end
    
#    respond_to do |format|
#      format.html # view_responses.html.erb
#      format.xml  { render :xml => @responses }
#    end
  end
  
  def view_responses
    if request.get?      
      @responses = Post.find(:all, :conditions => "response_id = #{params[:id]}") # TODO put newest first    
      @user_id_in_session = session[:user_id]
    end
#    @cheer = Cheer.find_by
    
#    @posts = @posts.select do |post|                  
#      #@cheer_id = get_cheer_for_user_post(@user_id_in_session, post.id).id
#      # Only return posts that are not responses
##      @cheer = get_cheer_for_user_post(@user_id_in_session, post.id)
#      #@block = lambda{ Cheer.find_by_user_id_and_post_id(@user_id_in_session, post.id) }
#      post.response_id == nil || post.response_id <= 0      
#    end
    
#      @cheer = get_cheer_for_user_post(0,0)
#    if @posts
#      @posts.each do |post|
#        @cheers << get_cheer_for_user_post(@user_id_in_session, post.id)  
#      end
#    end
        
          
    #@cheer = get_cheer_for_user_post(post.user_id, post.id)
           
    respond_to do |format|
      format.html # view_responses.html.erb
      format.xml  { render :xml => @responses }
    end
  end
  
  
end
