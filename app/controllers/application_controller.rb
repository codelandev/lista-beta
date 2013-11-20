class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:email, :name, :website, :pitch, :description, 
                                                 :screenshot, :status, :state, :city, :market_list, :code]

    devise_parameter_sanitizer.for(:sign_in) << :email

    devise_parameter_sanitizer.for(:account_update) << [:email, :name, :website, :pitch, :description, 
                                                        :screenshot, :status, :state, :city, :market_list, 
                                                        :password]
  end
end
