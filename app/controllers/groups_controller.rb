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

  def invite_send
    @group = Group.find(params[:id])
    @user = User.find(params[:user])
    unless !invite_send_validate?
      @group.invites.push(@user.id)
      if @group.save
        Message.send_group_invite(current_user, @user, @group)
        flash[:success] = @user.name + " convidado para o grupo."
      else
        flash[:danger] = "Erro inesperado!"
      end
    end
    redirect_to @group
  end

  def invite_accept
    @group = Group.find(params[:id])
    @user = User.find(params[:user])
    unless !invite_accept_validate?
      @group.invites.delete(@user.id)
      @group.participants.push(@user.id)
      if @group.save
        flash[:success] = "Entrou em: \"" + @group.title + "\" com sucesso!"
      else
        flash[:danger] = "Erro inesperado!"
      end
    end
    redirect_to @group
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

  def invite_send_validate?
    if !@group.have_user_as?(@current_user, 'admins')
      flash[:danger] = 'Você deve ser um administrador do grupo para convidar outras pessoas!'
      return false
    elsif @group.have_user_as?(@user, 'participants')
      flash[:danger] = @user.name + ' já é um participante deste grupo!'
      return false
    elsif @group.have_user_as?(@user, 'invites')
      flash[:danger] = @user.name + ' já é um participante deste grupo!'
      return false
    end
    return true
  end

  def invite_accept_validate?
    if !@group.have_user_as?(@current_user, 'invites')
      flash[:danger] = 'Você tentou entrar em um grupo que não foi convidado!'
      return false
    elsif @group.have_user_as?(@current_user, 'participants')
      flash[:danger] = 'Você tentou entrar em um grupo que ja faz parte!'
      return false
    elsif !current_user?(@user)
      flash[:danger] = 'Você não pode aceitar convites para outras pessoas!'
      return false
    end
    return true
  end

  def user_params
    params.require(:group).permit(:title, :description)
  end
end
