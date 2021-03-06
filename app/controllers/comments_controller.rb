class CommentsController < ApplicationController

    def create
        @deed = Deed.find(params[:deed_id])
        # @comment = @deed.comments.build(@comment_params)
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.deed_id = @deed.id
        if  @comment.save
            flash[:success] = "Comment created!"
            redirect_to deed_path(@deed)
        else
            flash[:alert] = "Comment not saved!"
            redirect_to deed_path(@deed)
        end 
     end
   

    def destroy
      
        @deed = Deed.find params[:deed_id]
        @comment = Comment.find params[:id]
        @comment.destroy
        flash[:alert] = "Removed comment!"
        redirect_to deed_path(@deed)
    end

    private 
    def comment_params 
        params.require(:comment).permit(:body)
    end 
end
