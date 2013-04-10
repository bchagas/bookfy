class User < ActiveRecord::Base
  has_many :albums

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.oauth_token = auth["credentials"]["token"]
    end
  end

  def instagram
    if provider == "instagram"
      @client ||= Instagram.client(access_token: oauth_token)
    end
  end
end
