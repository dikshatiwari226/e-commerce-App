class UserMailer < ApplicationMailer

 	def welcome_email(user)
    @user = user
    @url  = 'http://www.gmail.com'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site and Order completed successfully')
  end

end
