module PostsHelper
  def add_cheer_button(post_id, user_id)  
    button_to 'Cheer!', {:controller => "posts", :action => "add_cheer", :post_id => post_id, :user_id => user_id}
  end
  
  def add_uncheer_button(post_id, user_id)
    button_to 'Uncheer!', {:controller => "posts", :action => "delete_cheer", :post_id => post_id, :user_id => user_id}
  end
  
  def add_response_link(post_id, user_id)
    link_to 'Add Response', {:action => 'add_response/', :id => post_id}
  end
  
  def add_view_responses_link(post_id)
    link_to 'View Responses', {:controller => 'posts', :action => 'view_responses'}
    #link_to 'View Responses', view_responses_posts_path
  end
  
  def get_num_cheers(post_id)
    @num_cheers = 0
    @cheers = Cheer.find_all_by_post_id(post_id)
    if @cheers
      @num_cheers = @cheers.length
    end    
    @num_cheers    
  end
end
