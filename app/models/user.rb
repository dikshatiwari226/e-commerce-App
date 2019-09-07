class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wishlists
  has_many :carts
  has_many :products, dependent: :destroy
  has_many :rating_reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  def name
    "#{email.split('@')[0]}"
  end

  def is_admin?
   return true if self.role =="admin"
  end


  GENDER = {1 => "Male", 2 => "Female"}

  def gender_display
  	User::GENDER[gender]
  end

  # validates :mobile_no, :presence => {:message => "Problem in mobile no"},
  # 											:numericality => true,
  # 											:length => {:minimum => 10, :maximum => 10 }
 	# validates_presence_of :name, :message => "Please enter name"
 	# validates_presence_of :gender, :message => "Please select gender"
 	# validates_presence_of :mobile_no, :message => "Please enter mobile_no"
  # validates_presence_of :image, :message => "Please enter image"
  # validates_presence_of :address, :message => "Please enter address"


end
