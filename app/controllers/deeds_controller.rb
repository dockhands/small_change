class DeedsController < ApplicationController

    before_action :find_deed, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show, :funded]
    

    def index

        if params[:tag]
        @deeds = Deed.tagged_with(params[:tag])
        else
        @not_fully_funded_deeds = Deed.all.order(created_at: :desc).not_fully_funded

        @interested_deeds = filter_uninterested_deeds(@not_fully_funded_deeds)

        @deeds = filter_deeds_user_has_funded(@interested_deeds) 

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
        @close_deeds = Deed.near([current_user.latitude, current_user.longitude], 100).not_fully_funded

        @interested_deeds= filter_uninterested_deeds(@close_deeds)
        @deeds = filter_deeds_user_has_funded(@interested_deeds) 


        render :index
        
    end


    def fully_funded
        @deeds = Deed.fully_funded.order(created_at: :desc)
    end


    def filter_deeds_user_has_funded(arr) 

        funded_deeds = [] 
        current_user.funded_deeds.each do |deed| 
            funded_deeds << deed.id
            puts deed
        end   


        @non_funded_deeds = [] 
        arr.each do |deed|
            if !funded_deeds.include? deed.id
                @non_funded_deeds << deed
            end 
        end 
        @non_funded_deeds
    end 

    def filter_uninterested_deeds(arr)
        
        uninterested_deeds = [] 
        current_user.uninteresteds.each do |deed| 
            uninterested_deeds << deed.deed_id
        end   

        @interested_deeds = []
        arr.each do |deed|
            if !uninterested_deeds.include? deed.id
                @interested_deeds << deed
            end 
        end 
        @interested_deeds
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
