class UsersController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]

    def new
        @user = User.new
    end 

    def show 
    end 


  def create
    @user = User.new user_params
    if @user.save
    #  session[:user_id] = @user.id
      flash[:success] = "Thank you for signing up!"
      redirect_to root_path
    else
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(
      :username,                                      
      :first_name,
      :last_name,
      :location, 
      :email,
      :image_url,
      :password,
      :password_confirmation
    )
  end


end
