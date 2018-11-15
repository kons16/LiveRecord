class UsersController < ApplicationController

	def show
    	@user = User.find(params[:id])
    	@microposts =  @user.microposts.paginate(page: params[:page], :per_page => 5)
	end

	def index

	end

end
