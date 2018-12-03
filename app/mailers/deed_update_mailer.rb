class DeedUpdateMailer < ApplicationMailer

    def notify_deed_funder(user)
        @user = user
      
    
        mail(to: @user.email, subject: "#{@user.full_name} deed you funded is update!")
 
     end   


end
