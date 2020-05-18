class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
           :trackable, :confirmable, :timeoutable

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :created_at, presence: true
  # validates :confirmed_at, presence: true
  # left up to Devise to validate
  # validates_presence_of :password_confirmation
  # validates_uniqueness_of :email, case_sensitive: true

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless self.class.exists?(authentication_token: token)
    end
  end

  def reset_authentication_token!
    update_attribute :authentication_token, Devise.friendly_token
    authentication_token
  end
end
