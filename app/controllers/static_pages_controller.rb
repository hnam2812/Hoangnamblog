class StaticPagesController < ApplicationController
  def home
  	 @entry = current_user.entry.build if logged_in?
  	 @entries = current_user.show_entries.paginate(page: params[:page],per_page: 4) if logged_in?
  end

  def about
  end
end
