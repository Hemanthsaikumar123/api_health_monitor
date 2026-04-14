class Api < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  validate :url_must_be_http_or_https

  private

  def url_must_be_http_or_https
    parsed_url = URI.parse(url.to_s)

    return if parsed_url.is_a?(URI::HTTP) && parsed_url.host.present?

    errors.add(:url, "must be a valid HTTP or HTTPS URL")
  rescue URI::InvalidURIError
    errors.add(:url, "must be a valid HTTP or HTTPS URL")
  end
end