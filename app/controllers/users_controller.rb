class UsersController < ApplicationController

	def index
		@users = User.all.paginate(page: params[:page], per_page: 4) 
	end


	def show
		@user = User.find(params[:id])
	end

	def destroy
	  @user = user.find(params[:id])
	  @user.destroy
	 
	  redirect_to users_path
	end
	

	def edit
  	@user = User.find(params[:id])
	end

	def update
	  @user = User.find(params[:id])
	  if @user.update(user_params)
	    redirect_to admin_user_path
	  else
	    render 'edit'
	  end
	end
 
	private
	def user_params
      params.require(:user).permit(:name, :email, :mobile_no, :gender, :image, :address)
  end
end