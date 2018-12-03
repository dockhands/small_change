class CommentsController < ApplicationController

    def create
        @deed = Deed.find(params[:deed_id])
        comment_params=  params.require(:comment).permit(:body)
        @comment = @deed.comments.build(comment_params)
        @comment.user = current_user
        puts "--------------------------"
        puts @comment.user.username
        
        if  @comment.save
            flash[:success] = "Comment created!"
            redirect_to deed_path(@deed)
        else
            flash[:alert] = "Comment not saved!"
            redirect_to deed_path(@deed)
        end 
     end
   

    # def create 
    #     @deed = Deed.find params[:deed_id]
    #     comment_params = params.require(:comment).permit(:body)
    #     @comment   = Comment.new comment_params
    #     @comment.deed = @deed
   
    #     if  @comment.save
    #     flash[:success] = "Comment created!"
    #     redirect_to deed_path(@deed)

    #     else
    #     render '/deed/show'
    #     end 
    # end 

    def destroy
      
        @deed = Deed.find params[:deed_id]
        @comment = Comment.find params[:id]
        @comment.destroy
        flash[:alert] = "Comment!"
        redirect_to deed_path(@deed)
    end
end
