class UserMailer < ActionMailer::Base
  default from: "from@rmangoes.com"
 
  def welcome_email(user)
    @user = user
    @url  = 'http://test.com/login'
    mail(to: @user.email, subject: 'Welcome to Rotten Mangoes')
  end
end