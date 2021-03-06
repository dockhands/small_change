class DeedsController < ApplicationController

    before_action :find_deed, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show, :funded]
    
    include DeedsHelper

    def index

        if params[:tag]
        @deeds = Deed.tagged_with(params[:tag])
        else
        @not_fully_funded_deeds = Deed.all.order(created_at: :desc).not_fully_funded

            if current_user.present?
            @interested_deeds = filter_uninterested_deeds(@not_fully_funded_deeds)

            @deeds = filter_deeds_user_has_funded(@interested_deeds) 
            else 
            @deeds = @not_fully_funded_deeds
            end 

        end 
      
    end

    def funded
        @deeds = Deed.viewable.order(created_at: :desc)
    end 

    def new
        @deed = Deed.new
       
    end

    def create
        @deed = Deed.new deed_params
        @deed.user = current_user
        if @deed.save
            puts "did save"
            flash[:success] = "Deed made!"
            redirect_to deed_path(@deed)
        else
            if @deed.errors
                flash.now[:danger] = @deed.errors.full_messages.join(", ")
            end
            render :new
        end
    end 

    def show
        if params[:tag]
            @deed = Deed.tagged_with(params[:tag])
        else
       
        @deed = find_deed
        @comment = Comment.new
  
        render :show  
        end 
    end 

    def edit 
    end 

    def update
        #when updating deed, we want to clear the slug so it updates too
        @deed = find_deed
        @deed.slug = nil

        #when owner of deed updates a fully funded deed, mail all funders
        if @deed.update deed_params and @deed.fully_funded?
            mail_all_deed_funders(@deed)
            redirect_to deed_path(@deed)

        elsif @deed.update deed_params
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
        @close_deeds = Deed.near([current_user.latitude, current_user.longitude], 100).not_fully_funded

        @interested_deeds= filter_uninterested_deeds(@close_deeds)
        @deeds = filter_deeds_user_has_funded(@interested_deeds) 


        render :index
        
    end


    def fully_funded
        @deeds = Deed.fully_funded.order(created_at: :desc)
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
        :completed_image, 
        :completed_body,
        :uploads,
        :money_raised,
        :all_tags,
        :uninterested,
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
