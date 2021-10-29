class ResultService
  attr_reader :payload, :errors, :status

  def initialize(payload: nil, errors: {}, status: :ok)
    @payload = payload
    @errors = errors
    @status = status
  end

  def fail?
    payload.nil?
  end

  def success?
    !fail?
  end
end
