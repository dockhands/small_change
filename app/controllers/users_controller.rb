class UsersController < ApplicationController

  before_action :find_current_user, only: [:edit, :update, :destroy]
  before_action :find_user, only: [:show, :created_deeds]
  #before_action :set_location


  def new
      @user = User.new
  end 

  def show 
  end 

  def edit
  end 


  def update
    if @user.update user_params
    redirect_to user_path(@user.id)
    else
    render :edit
    end
end

  def create
    @user = User.new user_params
    if @user.save
    #  session[:user_id] = @user.id
      flash[:success] = "Thank you for signing up!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
  
      render :new
    end
  end

  def created_deeds
    @created_deeds = find_user.deeds
  end

  def funded_deeds
    @funded_deeds = find_user.funded_deeds
  end

  private

  def user_params
    params.require(:user).permit(
      :username,                                      
      :first_name,
      :last_name,
      :location, 
      :email,
      :wallet,
      :image_url,
      :password,
      :address,
      :city,
      :longitude,
      :latitude,
      :image,
      :password_confirmation
    )
  end

  def find_current_user
    @user = current_user
  end

  def find_user
    @user = User.find params[:id]
  end

end
