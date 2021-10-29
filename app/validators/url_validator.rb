require 'open-uri'

class UrlValidator < ActiveModel::Validator
  def validate_each(record, attribute, value)
    status = open(value).status.first
    unless status != '200'
      record.errors.add attribute, ['invalid url']
    end
  end
end