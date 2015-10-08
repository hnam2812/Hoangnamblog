class StaticPagesController < ApplicationController
  def home
  	 @entry = current_user.entry.build if logged_in?
  	 @entries = current_user.show_entries.paginate(page: params[:page]) if logged_in?
  	 @comment = Comment.new
  end

  def about
  end
end
