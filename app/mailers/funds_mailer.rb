class FundsMailer < ApplicationMailer

    def notify_deed_owner(fund)
        @user = fund.user
        @deed = fund.deed
        mail(to: @deed.user.email, subject: "#{@user.full_name} completed your funding")
    end
    
end
