class ResultService
  attr_reader :payload, :errors

  def initialize(payload: nil, errors: {})
    @payload = payload
    @errors = errors
  end

  def fail?
    payload.nil?
  end

  def success?
    !fail?
  end
end
