class ApplicationController < ActionController::Base
  before_action :set_locale
  
  layout :layout
  
  def set_locale
    if params[:locale]
      cookies[:locale] = params[:locale]
    end 
    
    if cookies[:locale]
      if I18n.locale != cookies[:locale]
        I18n.locale = cookies[:locale]
      end    
    end
  end
  
  private
  
  def layout
    if is_a?(Devise::SessionsController) || is_a?(Devise::PasswordsController)
      'devise'
    else
      'application'
    end
  end
end
