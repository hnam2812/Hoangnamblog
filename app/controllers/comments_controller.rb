class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		 if @comment.save
      flash[:success] = "Your comment posted successful"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
	end

  private

    def comment_params
      params.require(:comment).permit(:content, :entry_id, :user_id)
    end

end
