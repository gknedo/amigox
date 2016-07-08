class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @current_user = current_user
      redirect_to @current_user
    end
  end

  def about
  end

  def help
  end

  def contact
  end
end
