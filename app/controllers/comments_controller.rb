class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
	def create
		@comment = Comment.new(comment_params)
    @entry = @comment.entry
		 if @comment.save
      flash[:success] = "Your comment posted successful"
      redirect_to @entry
    else
      flash[:danger] = "Comment must not empty and less than 150 characters!"
      redirect_to @entry

    end
	end
 
  def edit
    @comment = current_user.comment.find_by(id: params[:id])

  end

  def update
     @comment = current_user.comment.find_by(id: params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment updated."
      redirect_to @comment.entry

    else
      render 'edit'  
    end
  end

  def destroy
     @comment.destroy
    flash[:success] = "Comment deleted!"
    redirect_to request.referrer || root_url #redirect to url before action, if nil redirect to root url
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
