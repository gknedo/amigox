class GroupsController < ApplicationController
  before_action :logged_in_user

  def new
    @group = Group.new(admins: @current_user.id)
  end

  def create
    @group = Group.new(user_params.merge(admins: [@current_user.id], participants: [@current_user.id]))
    if @group.save
      flash[:success] = "Grupo criado com sucesso."
      redirect_to @group
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = Group.paginate(page: params[:page])
  end

  #Before filters

  # Confirms a owner.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Por favor, esteja logado para visualizar esse conteúdo"
      redirect_to login_url
    end
  end

  private

  def user_params
    params.require(:group).permit(:title, :description)
  end
end
