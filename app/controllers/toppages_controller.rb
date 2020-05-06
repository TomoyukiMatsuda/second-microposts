class ToppagesController < ApplicationController
  def index
    if logged_in?
      @micropost = current_user.microposts.build
      @microposts = current_user.microposts.order(id: :desc).page(params[:page]).per(5)
    end
  end
end
