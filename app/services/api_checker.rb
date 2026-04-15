require 'net/http'
require 'uri'

class ApiChecker
  def self.check(api)
    uri = URI.parse(api.url)

    start_time = Time.now

    begin
      response = Net::HTTP.get_response(uri)
      end_time = Time.now

      status = response.code.to_i == 200 ? "up" : "down"

      api.health_checks.create(
        status: status,
        response_time: end_time - start_time,
        status_code: response.code.to_i,
        checked_at: Time.now
      )

    rescue => e
      api.health_checks.create(
        status: "down",
        response_time: nil,
        status_code: nil,
        checked_at: Time.now
      )
    end
  end
end