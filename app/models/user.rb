class User < ActiveRecord::Base
  has_many :post
  has_many :cheer
  
  validates_presence_of :login, :first_name, :last_name, :email, :pw  
  validates_format_of(:email, :with => /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/, :message => ": Invalid email address")  
  validates_uniqueness_of(:login, :message => "Username is already in use.")
  validates_uniqueness_of(:email, :message => "Email address is already in use.")
  validates_length_of(:pw, :within => 6..16)
  
#  protected
#  def passwords_must_match
#    errors.add()
#  end

  def self.authenticate(login, pw)
    #debug "Authenticate"
    user = self.find_by_login(login)
    if user
      if user.pw != pw
        user = nil
        #flash[:notice] = "Invalid username/password combination."
      end    
    else
      #flash[:notice] = "Username #{login} does not exist"
    end
    user #return
  end
  
end
