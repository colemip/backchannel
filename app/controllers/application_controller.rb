# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout 'application' # app/view/layours/application.html.erb
#  before_filter :require_login, :except => :login
  

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def require_login      
    @user_session = session[:user_id]
    if !@user_session
      flash[:notice] = "You must be logged in." 
      redirect_to(:controller => "login", :action => "login")        
    end
  end
  
  def require_admin
    @admin = session[:admin]
    if !@admin
      flash[:notice] = "You must be an admin to access this page."
      redirect_to(:controller => "login", :action => "login")   
    end    
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:controller => "login", :action =>"login")
  end
  
#  def add_button(text, controller, action)
#    button_to text, {:controller => controller, :action => action }
#  end
  
end
