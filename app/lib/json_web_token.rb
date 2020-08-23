class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = 'f55bd5dbf6f33f476d600e4ffbc9552bc5ed80a8c8baebcc8a08541a8c6b52bfe3156e30e5760cd07b19ff81cccb1733b5fef659f268215d7b814891685bf14b'

  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end
