class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_create :allot_score

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_name, :college, :provider, :uid, :name
  # attr_accessible :title, :body

  validates :name, :presence => true, :length => {:maximum => 35},
  :format => {:with => /^[A-Za-z ]+$/, :message => " should only have alphabets"}

  validates :user_name, :uniqueness => true, :presence => true, :length => {:maximum => 50}
  validates :college, :presence => true

  has_many :attempts, :dependent => :destroy

  def self.find_for_facebook_oauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
   
    user.save!
  end
end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private
    
    def allot_score
      self.score = 1
    end

end
