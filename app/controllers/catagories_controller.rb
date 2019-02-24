class CatagoriesController < ApplicationController

	before_action :set_catagory, only: [:destroy]
	before_action :check_user_auth, only: [:destroy]
	

  def index
  	@catagories = current_user.catagories
  end

  def new
  	@catagory = Catagory.new
  end

  def create
  	@catagory = current_user.catagories.new(catagory_params)
  	if @catagory.save
  		redirect_to catagories_path, flash: {success: "Catagory added successfully"}
  	else
  		flash_now!(:error => @catagory.errors.full_messages.join(', '))
			render ("new")
  	end
  end

  def destroy
  	if @catagory.destroy
  		redirect_to catagories_path, flash: {success: "Catagory deleted successfully"}
  	else
  		redirect_to catagories_path, flash: {error: @catagory.errors.full_messages.join(', ')}
  	end
  end

  private

  def catagory_params
  	params.require(:catagory).permit(:name)
  end

  def check_user_auth
  	unless @catagory.user == current_user
  		redirect_to catagories_path, flash: {error: "Unauthoried Access"}
  	end
  end


  def set_catagory
  	@catagory = Catagory.find(params[:id])
  end
  
end
