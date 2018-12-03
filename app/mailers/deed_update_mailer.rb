class DeedUpdateMailer < ApplicationMailer

    def notify_deed_funder(user, deed)
        @user = user
        @deed = deed 
    
        mail(to: @user.email, subject: "#{@user.full_name}, #{@deed.title} was completed. Please rate it!")
 
     end   


end
