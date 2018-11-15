class MicropostsController < ApplicationController

  def new
    @micropost = Micropost.new
  end

  def create
 	@micropost = current_user.microposts.build(micropost_params)

  	if @micropost.save
  		redirect_to current_user
  	else
  		render 'new'
  	end

  end

  private

  	def micropost_params
  		 params.require(:micropost).permit(:year, :month, :day, :teama, :teamb,
  		 	:place, :myteam, :artist, :livetitle, :logo, :apoint, :bpoint)
  	end

end
