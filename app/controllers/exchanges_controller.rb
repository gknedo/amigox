class ExchangesController < ApplicationController
  before_action :logged_in_user


  def new
    @exchange = Exchange.new(admins: @current_user.id)
  end

  def create
    @exchange = Exchange.new(user_params.merge(admins: [@current_user.id]))
    if @exchange.save
      flash[:info] = "Amigo secreto criado."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @exchanges = Exchange.paginate(page: params[:page])
  end

  def show
    @exchange = Exchange.find(params[:id])
  end

  #Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Por favor, esteja logado para visualizar esse conteúdo"
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  private

  def user_params
    params.require(:exchange).permit(:title,:description)
  end
end