class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.hex
      return unless self.class.exists?(authentication_token: authentication_token)
    end

    authentication_token
  end
end
