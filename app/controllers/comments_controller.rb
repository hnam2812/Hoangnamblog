class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
	def create
		@comment = Comment.new(comment_params)
    @entry = @comment.entry
		 if @comment.save
      flash[:success] = "Your comment posted successful"
      redirect_to root_url
    else
      flash[:danger] = "Comment must less than 150 characters!"
      redirect_to @entry
    end
	end

  private

    def comment_params
      params.require(:comment).permit(:content, :entry_id, :user_id)
    end
    def correct_user
       @comment = current_user.comment.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
