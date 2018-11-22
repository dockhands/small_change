class DeedsController < ApplicationController

    before_action :find_deed, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]


    def index
        @deeds = Deed.all.order(created_at: :desc)
    end

    def new
        @deed = Deed.new

    end

    def create
        @deed = Deed.new deed_params
        @deed.user = current_user
        puts "============================inside create"
        if @deed.save
            puts "did save"
            flash[:success] = "Deed made!"
            redirect_to deed_path(@deed)
        else
            puts "================================didn't save"
            if @deed.errors
                flash.now[:danger] = @deed.errors.full_messages.join(", ")
            end
            render :new
        end
    end 

    def show
        @deed = find_deed
        render :show  
    end 

    def edit 
    end 

    def update
        if @deed.update deed_params
          redirect_to deed_path(@deed.id)
        else
          if @deed.errors.present?
            flash[:danger] = @deed.errors.full_messages.join(" • ")
          end 
          render :edit
        end
    end

    def destroy
        @deed.destroy
        redirect_to deeds_path
    end

    private 

    def deed_params
        params.require(:deed).permit(:deed, :title, :body, :money_required, :image_url, :location)
    end

    def find_deed
        @deed = Deed.find params[:id]
    end
end
