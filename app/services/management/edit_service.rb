
=begin
input: params[:alias], params[:origin_changed]

process: update old record.origin with params[:origin_changed]

output: record edited
=end

class Management::EditService < BaseService
  include Entityable
  include Aliasable
  include Urlable

  def initialize alias_path:'', origin_changed:''
    @alias = alias_path
    @origin = origin_changed
  end

  def call 
    return ResultService.new errors: not_found_error if record.nil? 
    return ResultService.new errors: validate_error if origin_invalid?
    ResultService.new payload: data
  end

  private 

  def origin_invalid?
    !url_exist? @origin
  end

  def data 
    record.update origin: @origin
    {success: true}
  end

  def not_found_error
    errors 
  end

  def validate_error
    {messages: ['origin url invalid']}
  end
end
