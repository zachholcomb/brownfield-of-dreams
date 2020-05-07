class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if url_valid?(value)

    record.errors[attribute] << (options[:message] || 'must be a valid URL')
  end

  def url_valid?(url)
    uri = URI.parse(url) rescue false
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  end
end
