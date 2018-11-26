class DeedsController < ApplicationController

    before_action :find_deed, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]


    def index

        if params[:tag]
            @deeds = Deed.tagged_with(params[:tag])
        else
        @deeds = Deed.all.order(created_at: :desc)
        end 
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
        @city = request.location.city 
        puts "----------------------- city"
        puts request.location.city 
        if params[:tag]
            @deed = Deed.tagged_with(params[:tag])
        else

        @deed = find_deed
        render :show  
        end 
    end 

    def edit 
    end 

    def update
        #when updating deed, we want to clear the slug so it update stoo
        @deed = find_deed
        @deed.slug = nil
        if @deed.update deed_params
          redirect_to deed_path(@deed)
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

    def near_me
       
        @close_deeds = Deed.near(params[:latitude => current_user.latitude, :longitude => current_user.longitude], 1000)
    

        puts "------------------------------close deeds-"
        puts @close_deeds
        puts "----------------------------USER longitude-"
        puts current_user.longitude
        puts current_user.latitude
        puts "-----------------------------DEED longitude-"
        puts Deed.last.longitude
        puts Deed.last.latitude

    end

    private 

    def deed_params
        params.require(:deed).permit(:deed, 
        :title, 
        :body, 
        :money_required, 
        :image_url, 
        :location, 
        :image, 
        :all_tags,
        :address,
        :city,
        :longitude,
        :latitude,)
    end

    def find_deed
        @deed = Deed.friendly.find(params[:id])
    end

    def to_param
        "#{id}-#{title}".parameterize
    end
end
