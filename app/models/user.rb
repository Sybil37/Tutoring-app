class User < ApplicationRecord
  has_many :payments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  after_commit :send_pending_devise_notifications
  # after_create_commit :send_welcome_mail



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

  protected

      
  def send_devise_notification(notification, *args)
              # If the record is new or changed then delay the
              # delivery until the after_commit callback otherwise
              # send now because after_commit will not be called.
      # byebug
      if new_record? || changed?
          pending_devise_notifications << [notification, args]
      else
          render_and_send_devise_message(notification, *args)
      end
  end
      
  private
      
  def send_pending_devise_notifications

          pending_devise_notifications.each do |notification, args|
          render_and_send_devise_message(notification, *args)
          end
      
          # Empty the pending notifications array because the
          # after_commit hook can be called multiple times which
          # could cause multiple emails to be sent.
          pending_devise_notifications.clear
  end
      
  def pending_devise_notifications
          @pending_devise_notifications ||= []
  end
      
  def render_and_send_devise_message(notification, *args)
          message = devise_mailer.send(notification, self, *args)
      
          # Deliver later with Active Job's `deliver_later`
          if message.respond_to?(:deliver_later)
             message.deliver_later
             # Remove once we move to Rails 4.2+ only, as `deliver` is deprecated.
          elsif message.respond_to?(:deliver_now)
              message.deliver_now
          else
              message.deliver
          end
  end

  # def send_welcome_mail
  #   # byebug
  #   UserMailer.welcome_email(self).deliver_later
  # end

  
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_now
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