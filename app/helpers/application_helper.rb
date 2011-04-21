# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper  
  def check_user_session
    session[:user_id] != nil
  end  
end
