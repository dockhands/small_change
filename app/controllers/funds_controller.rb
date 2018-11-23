class FundsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_deed
    before_action :find_fund, only: [:destroy]


    def create
      fund          = Fund.new
      deed          = Deed.find params[:deed_id]
      fund.deed     = deed
      fund.user     = current_user
      if fund.save
        redirect_to deeds_path, notice: "Thanks for funding!!"

        puts "-----------------------------------------"
        if deed.funds.count === deed.money_required 
          puts "reached funding"
        end 

        puts " ============ Deed Creator: "
        puts deed.user.username
        puts deed.user.wallet 

        puts " ============== Deed Funder: "
        puts fund.user.username
        puts fund.user.wallet
       # fund.user.wallet -1
        puts fund.user.wallet 

      else
        redirect_to deed_path(deed), alert: "Can't fund! Already funded?"
      end
    end

    def destroy
      
        deed          = Deed.find params[:deed_id]
        fund     = current_user.funds.find params[:id]
        fund.destroy
        redirect_to deeds_path, notice: "Removed funding"
      end

      private 
      def find_deed
        @deed = Deed.find(params[:deed_id])
      end

      def find_fund
        @fund = @deed.funds.find(params[:id])
       end

end
