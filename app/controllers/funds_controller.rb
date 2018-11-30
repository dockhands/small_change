class FundsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_deed
    before_action :find_fund, only: [:destroy]


    def create
      fund          = Fund.new
      deed          = Deed.find_by slug: params[:deed_id]
      fund.deed     = deed
      fund.user     = current_user

      if current_user.wallet < 1
       
        flash[:danger] = "Your wallet is empty. You can always add more funds."
        redirect_to user_path(current_user)
      
      elsif fund.save && deed.funds.count === deed.money_required 
        fund.user.wallet -= 1
        current_user.save
     
        FundsMailer.notify_deed_owner(fund).deliver_now
        deed.meets_required_funding!
        puts deed.aasm_state
        flash[:success] = "Deed fully funded!"
        redirect_to deeds_path
     
      elsif fund.save && !(deed.funds.count === deed.money_required) 
        fund.user.wallet -= 1
        current_user.save
        puts "============================deed funded : ) "
        flash[:success] = "Thanks for funding!"
        redirect_to deeds_path
     
      else
        flash[:danger] = "Can't fund! Already funded?"
        redirect_to deed_path(deed) 
      end
    end

    def destroy
    
        deed     = Deed.find params[:deed_id]
        fund     = current_user.funds.find params[:id]

      if deed.fully_funded?
        flash[:danger] = "Can't unfund a fully funded deed. Sorry..."
        redirect_to deeds_path

      elsif 

        fund.user.wallet += 1
        current_user.save
        fund.destroy
        flash[:success] =  "Removed funding"
        redirect_to deeds_path 
      end
    end 

 

      private 
      def find_deed
        @deed = Deed.find(params[:deed_id])
      end

      def find_fund
        @fund = @deed.funds.find(params[:id])
      end

end
