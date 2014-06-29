class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  # forzo signout per prevenire attacchi
  def handle_unverified_request
    sign_out
  end

end
