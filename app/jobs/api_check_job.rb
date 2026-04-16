class ApiCheckJob < ApplicationJob
  queue_as :default

  def perform
    Api.find_each do |api|
      ApiChecker.check(api)
    end
  end
end