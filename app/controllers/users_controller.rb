class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update]
	before_action :correct_user,   only: [:edit, :update, :add]


	def show
    	@user = User.find(params[:id])
    	@microposts =  @user.microposts.paginate(:page => params[:page], :per_page => 5)
	end

	def index

	end

	private

	    # 正しいユーザーかどうかを確認
	    def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless @user == current_user
		end

end
