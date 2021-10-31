
=begin
input: params alias

output: {
  data: {
    success: true
  }
}
=end

class Management::DestroyService < BaseService
  include Entityable
  include Aliasable

  def initialize alias_path:''
    @alias = alias_path
  end

  def call
    return ResultService.new errors: errors if record.nil?
    ResultService.new payload: data 
  end

  private

  def data 
    record.destroy
    { success: true }    
  end
end