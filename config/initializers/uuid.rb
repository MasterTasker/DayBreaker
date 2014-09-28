require 'uuid'

class UuidValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value and not UUID.validate(value)
      record.errors[attribute] << (options[:message] || 'is not a a valid uuid')
    end
  end
end
