class ApplicationController < ActionController::Base
  before_action :basic_certifiaction

  private

  def basic_certifiaction
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_NAME'] && password == ENV['BASIC_PASS']
    end
  end
end
