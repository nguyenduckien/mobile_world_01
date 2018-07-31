class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def require_login
    return if logged_in?
    flash[:danger] = t ".login_check"
    redirect_to login_url
  end

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by id: session[:cart_id]
      cart.present? ? @current_cart = cart : session[:cart_id] = nil
    end

    if session[:cart_id].nil?
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
      @current_cart.user_id = current_user.id
      @current_cart.save
    end
  end

end
