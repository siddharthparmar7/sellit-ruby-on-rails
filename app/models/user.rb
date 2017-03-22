class User < ApplicationRecord
  has_many :items
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    # byebug
     user.email = auth.uid.to_s + "@facebook.com"
     user.name = auth.info.name
     user.password = Devise.friendly_token[0,20]
     user.save!
   end
  end
end
