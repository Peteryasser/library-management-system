module JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    payload[:jti] = SecureRandom.uuid 
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY)[0]
    jti = decoded_token['jti']

    # Check if the token is blacklisted
    if TokenBlacklist.exists?(jti: jti)
      return nil
    end

    HashWithIndifferentAccess.new(decoded_token)
  rescue JWT::DecodeError
    nil
  end
end
