class JsonWebToken

  # Secret to encode and decode the token, unique to this rails app.
  #HMAC_SECRET = Rails.application.secrets.secret_key_base
  HMAC_SECRET = "Huh"

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i

    # Sign the token with the application secret.
    JWT.encode(payload, HMAC_SECRET.to_s)
  end

  def self.decode(token)
    # Get the payload, first index in the decoded array.
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new(body)

    # Rescue from decode errors.
  rescue JWT::DecodeError => e 
    # Raise custom error to be handled by custom handler.
    raise ExceptionHandler::InvalidToken, e.message
  end
end