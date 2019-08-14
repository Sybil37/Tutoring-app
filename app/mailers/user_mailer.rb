class UserMailer < ApplicationMailer
    
    def welcome_email(user)
        @user = user
        @url  = 'sybling.site/users/sign_in'
        mail(to: @user.email, subject: 'Welcome to s-tutoring')
    end
end
