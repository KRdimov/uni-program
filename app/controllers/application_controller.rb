require "error_handler"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :add_cors_response_header

  def add_cors_response_header 
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET'
  end

  include ErrorHandler
end
