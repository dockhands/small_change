module DeedsHelper

    def tag_links(tags)
        tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ") 
    end

    def mail_all_deed_funders(deed)
        
        deed.funds.each do |fund| 
        user = fund.user 
            DeedUpdateMailer.notify_deed_funder(user,deed).deliver_now
        end  
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


end
