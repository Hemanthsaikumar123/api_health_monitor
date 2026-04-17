require 'net/http'
require 'uri'

class ApiChecker
  def self.check(api)
    uri = URI.parse(api.url)

    start_time = Time.now

    begin
      response = Net::HTTP.get_response(uri)
      end_time = Time.now

      current_status = response.code.to_i == 200 ? "up" : "down"

      last_check = api.health_checks.order(checked_at: :desc).first
      previous_status = last_check&.status

      # 🔔 ALERT LOGIC
      if previous_status && previous_status != current_status
        Rails.logger.info "🚨 ALERT: #{api.name} changed from #{previous_status} to #{current_status}"
      end

      api.health_checks.create(
        status: current_status,
        response_time: end_time - start_time,
        status_code: response.code.to_i,
        checked_at: Time.current
      )

    rescue => e
      current_status = "down"

      last_check = api.health_checks.order(checked_at: :desc).first
      previous_status = last_check&.status

      if previous_status && previous_status != current_status
        Rails.logger.info "🚨 ALERT: #{api.name} is DOWN"
      end

      api.health_checks.create(
        status: "down",
        response_time: nil,
        status_code: nil,
        checked_at: Time.current
      )
    end
  end
end