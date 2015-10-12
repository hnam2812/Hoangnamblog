class EntriesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
	def create
    @entry = current_user.entry.build(entry_params)
    if @entry.save
      flash[:success] = "Your entry posted successful"
      redirect_to root_url
    else
      @entries = []
      render 'static_pages/home'
    end
  end

  def destroy
    @entry.destroy
    flash[:success] = "Entry deleted!"
    redirect_to request.referrer || root_url #redirect to url before action, if nil redirect to root url

  end

  def show
    @entry = current_entry
    @comment = Comment.new
    if @entry.nil?
      flash[:warning] = "Entry does not exist."
      redirect_to root_url
    end
    # @comments = @entry.comments.all
  end

  def edit
    @entry = current_user.entry.find_by(id: params[:id])
  end

  def update
    @entry = current_user.entry.find_by(id: params[:id])
    if @entry.update_attributes(entry_params)
      flash[:success] = "Entry updated."
      redirect_to @entry
    else
      render 'edit'
    end
  end

  private

    def entry_params
      params.require(:entry).permit(:title, :content, :comment)
    end
    def correct_user
       @entry = current_user.entry.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
