class UninterestedsController < ApplicationController
    before_action :authenticate_user!

    def create
        uninterested      = Uninterested.new
        deed              = Deed.find_by slug: params[:deed_id]
        uninterested.deed = deed
        uninterested.user     = current_user
        if  uninterested.save
            puts "saved as uninterested! "
          redirect_to deeds_path
        else
          flash[:danger] = "Already swipped no?"
          redirect_to deeds_path
        end
      end

    private 
    def find_deed
      @deed = Deed.find(params[:deed_id])
    end
end
