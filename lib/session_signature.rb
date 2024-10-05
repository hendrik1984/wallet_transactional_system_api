module SessionSignature
  def self.generate_token(key)
    secret_key = self.get_secret_key
    token_expired = Rails.application.credentials.api[:timeout]
    
    if key.present?
      if key == secret_key
        timestamp = (Time.now + (token_expired.to_i).minutes).to_i.to_s
        token = Base64.urlsafe_encode64(key+':'+timestamp)
      else
        raise 'Key Invalid'
      end
    end
  end

  def self.verify(token)
    # token is not found
    raise 'Token not found' if token.nil?

    secret_key = self.get_secret_key
    key, time = Base64.urlsafe_decode64(token).split(':')
    
    # Token data Expired time not found
    raise "Token Invalid" if time.nil?

    # validate expired time
    raise 'Token Expired' if time.to_i < Time.now.to_i

    # validate if generate token valid
    verify_token = Base64.urlsafe_encode64(key+':'+time)
    raise 'Token Invalid' if token != verify_token

    return true
  end

  def self.get_secret_key
    secret_key = Rails.application.credentials.api[:key]
  end
end