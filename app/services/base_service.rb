class BaseService
  def self.call(*arg)
    new(*arg).call
  end

  def call
    raise NotImplementedError, "Missing instance method `call` of #{self.class} class"
  end
end
