class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  
  def set_authentication_token
    new_token = generate_authentication_token
    update_attributes(authentication_token: new_token)
    return new_token
  end

  def generate_authentication_token
    token = nil
    loop do
      token = SecureRandom.hex
      return token unless self.class.exists?(authentication_token: token)
    end
  end
end
