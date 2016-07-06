class ExchangesController < ApplicationController
  before_action :logged_in_user


  def new
    @exchange = Exchange.new(admins: @current_user.id)
  end

  def create
    @exchange = Exchange.new(user_params.merge(admins: [@current_user.id], participants: [@current_user.id]))
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

  def destroy
    Exchange.find(params[:id]).destroy
    flash[:success] = "Amigo secreto deletado"
    redirect_to exchanges_path
  end

  def invite_send_confirm
    @exchange = Exchange.find(params[:id])
    @user = User.find(params[:user])
    invite_send_validate
  end

  def invite_send
    @exchange = Exchange.find(params[:id])
    @user = User.find(params[:user])
    invite_send_validate
    @exchange.invites.push(@user.id)
    if @exchange.save
      flash[:success] = @user.name + " convidado para o amigo secreto."
    else
      flash[:danger] = "Erro inesperado!"
    end
    redirect_to @exchange
  end

  def invite_accept_confirm
    @exchange = Exchange.find(params[:id])
    @user = User.find(params[:user])
    invite_accept_validate
  end

  def invite_accept
    @exchange = Exchange.find(params[:id])
    @user = User.find(params[:user])
    invite_accept_validate
    @exchange.invites.delete(@user.id)
    @exchange.participants.push(@user.id)
    if @exchange.save
      flash[:success] = "Entrou em: \"" + @exchange.title + "\" com sucesso!"
    else
      flash[:danger] = "Erro inesperado!"
    end
    redirect_to @exchange

  end

  private

  def invite_send_validate
    if !@exchange.have_user_as?(@current_user, 'admins')
      flash[:danger] = "Você deve ser um administrador do amigo secreto para convidar outras pessoas!"
      redirect_to exchanges_path
    elsif @exchange.have_user_as?(@user, 'participants')
      flash[:info] = @user.name + " já é um participante deste amigo secreto!"
      redirect_to exchanges_path
    end
  end

  def invite_accept_validate
    if !@exchange.have_user_as?(@current_user, 'invites')
      flash[:danger] = "Você tentou entrar em um amigo secreto que não foi convidado!"
      redirect_to exchanges_path
    elsif @exchange.have_user_as?(@current_user, 'participants')
      flash[:danger] = "Você tentou entrar em um amigo secreto que ja faz parte!"
      redirect_to exchanges_path
    elsif !current_user?(@user)
      flash[:danger] = "Você não pode aceitar convites para outras pessoas!"
      redirect_to exchanges_path
    end
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
    params.require(:exchange).permit(:title, :description)
  end
end