class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update]
	before_action :correct_user,   only: [:edit, :update, :add]

	# マイページにアクセス
	def show
    	@user = User.find(params[:id])
    	@archive_year = params[:archive_year]
    	@microposts =  @user.microposts.paginate(:page => params[:page], :per_page => 5)

    	# アーカイブ時
    	if @archive_year.present?
    		@microposts = @microposts.where(year: @archive_year)
    	end

    	# 並び替え
    	@microposts = @microposts.order(year: "DESC")
    	@microposts = @microposts.order(month: "DESC")
    	@microposts = @microposts.order(day: "DESC")

    	# Archive
    	@years = []
    	@cnt_year = []	# その年度に追加したチケットの枚数
    	@cnt_allyear = []
    	@years = @user.microposts.pluck(:year)
    	@years = @years.uniq

    	@years.each { |year| @cnt_year.push(@user.microposts.where(year: year).count) }
    	@cnt_allyear = @user.microposts.count

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
