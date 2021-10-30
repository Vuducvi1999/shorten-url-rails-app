class UrlValidator < ActiveModel::EachValidator
  include Urlable 
  
  def validate_each(record, attribute, value)
    unless url_exist? value 
      record.errors.add attribute, 'invalid url'
    end
  end
end