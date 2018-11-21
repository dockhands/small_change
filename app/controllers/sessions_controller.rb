class SessionsController < ApplicationController

    def new 
    end 
    
    def create
        @user = User.find_by_email params[:session][:email]
    
        if @user&.authenticate(session_params[:password])
            session[:user_id] = @user.id
            flash[:success] = "Signed in!"
            redirect_to deeds_path
    
        else 
            flash.now[:danger] = "Incorrect Email or Password. Try again."
            render :new     
        end 
    end 

    private 
    def session_params 
        params.require(:session).permit(:email, :password)
    end 

end
