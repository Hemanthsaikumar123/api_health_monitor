class HealthChecksController < ApplicationController
  def index
    @api = Api.find(params[:api_id])
    @health_checks = @api.health_checks.order(checked_at: :desc)
  end
end