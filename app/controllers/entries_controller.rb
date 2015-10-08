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

  private

    def entry_params
      params.require(:entry).permit(:title, :content)
    end
    def correct_user
       @entry = current_user.entry.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
