class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :async,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  def self.from_omniauth(auth)
    # byebug
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end

    
  end
end

# application_controllers
# post '/registrations' do
#    user = User.create(name: params["name"], email: params["email"])
#    user.password = params["password"]
#    user.save
#    session[:user_id]=user.id
#    redirect 'users/home'
#   end
# ...................................
# class User < ActiveRecord::Base
# def password
#     @password ||= Password.new(password_hz