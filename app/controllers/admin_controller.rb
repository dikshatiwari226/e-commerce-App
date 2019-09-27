class AdminController < ApplicationController
	layout 'admin'
  before_action :authentication_admin!
 
	def index
    if params[:id].present?
      @category = Category.find(params[:id])
      @products_all = @category.products.paginate(page: params[:page], per_page: 4)
    elsif 
      if params[:search].present?
      @products_all = Product.where("lower(name) LIKE :prefix OR lower(name) LIKE :prefix", prefix: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 2)
      end
    else
      @products_all = Product.all.paginate(page: params[:page], per_page: 4)
    end
  end
  
end
