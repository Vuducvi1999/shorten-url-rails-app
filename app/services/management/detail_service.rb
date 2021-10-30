
=begin
input: params[:alias]

output: {
    origin_url,
    shorten_url,
    clicked,
    created_at,
    updated_at
}
=end

class Management::DetailService < BaseService
  include Entityable
  include Aliasable

  def initialize alias_path:''
    @alias = alias_path
  end

  def call
    return ResultService.new errors: errors, status: :unprocessable_entity if record.nil?
    ResultService.new payload: record
  end

  private 
end