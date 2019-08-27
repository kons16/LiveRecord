class MicropostsController < ApplicationController
  before_action :logged_in_user, only:[:new, :create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @micropost = Micropost.new
    @url = current_user
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to request.referrer || root_url
  end

private

def micropost_params
 params.require(:micropost).permit(:year, :month, :day, :teama, :teamb,
  :place, :myteam, :artist, :livetitle, :logo, :apoint, :bpoint)
end

def correct_user
 @micropost = current_user.microposts.find_by(id: params[:id])
 redirect_to root_url if @micropost.nil?
end

end
