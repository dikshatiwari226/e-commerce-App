class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
	
	# before_action :authenticate_user!
  # helper_method :current_order
	
  # def current_order
  #   if session[:order_id]
  #     Order.find(session[:order_id])
  #   else
  #     Order.new
  #   end
  # end 
  # ==========  current user cart create =====

  def current_cart
    if current_user.present?
      return Cart.find_or_create_by(user_id: current_user.id, is_done: false)
    end
  end
  helper_method :current_cart
  # ===================================

  protect_from_forgery with: :exception
  before_action :user_admin, expect:[:after_sign_in_path_for]
  include ApplicationHelper
  layout :set_layout
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :check_subscription
  def after_sign_in_path_for(resource)
    resource.is_admin? ? admin_root_path : root_path
  end

	def user_admin
    if request.fullpath.split("/")[1] == "admin"
      if current_user.role != 'admin'
        redirect_to root_path
      else
        request.url
      end
    else
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role, :first_name, :last_name, :image, :is_active, :is_admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :role, :first_name, :last_name, :image, :is_active, :is_admin])

  end

	def authentication_admin!
    unless current_user.is_admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
  end
	
	protected   
  	def configure_permitted_parameters  
  		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit({ roles: [] }, :email, :password, :password_confirmation,:name, :gender,:mobile_no, :image, :address)
    end
		  devise_parameter_sanitizer.permit(:account_update) do |user_params|
    	user_params.permit({ roles: [] }, :email, :password, :password_confirmation,:name, :gender,:mobile_no, :image, :address,:current_password)
   	end
	end
	
end
