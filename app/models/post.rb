class Post < ActiveRecord::Base
  require 'validations' # for custom validations
  
  belongs_to :user
  # require all fields
  validates_presence_of :title, :body, :user_id        
#  validates_positive :user_id # TODO Add this later -- see lib/validations.rb
  

end
