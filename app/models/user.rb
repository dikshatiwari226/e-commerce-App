class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  GENDER = {1 => "Male", 2 => "Female"}

  def gender_display
  	User::GENDER[gender]
  end

  validates :mobile_no, :presence => {:message => "Problem in mobile no"},
  											:numericality => true,
  											:length => {:minimum => 10, :maximum => 10 }
 	validates_presence_of :name, :message => "Please enter name"
 	validates_presence_of :gender, :message => "Please enter name"
 	validates_presence_of :name, :message => "Please enter name"


end
