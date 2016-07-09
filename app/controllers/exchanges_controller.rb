class ExchangesController < ApplicationController
  before_action :logged_in_user


  def new
    @exchange = Exchange.new(admins: @current_user.id)
  end

  def create
    @exchange = Exchange.new(user_params.merge(admins: [@current_user.id], participants: [@current_user.id]))
    if @exchange.save
      flash[:success] = "Amigo secreto criado."
      redirect_to @exchange
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

  def invite_send
    @exchange = Exchange.find(params[:id])
    @user = User.find(params[:user])
    unless !invite_send_validate?
      @exchange.invites.push(@user.id)
      if @exchange.save
        flash[:success] = @user.name + " convidado para o amigo secreto."
      else
        flash[:danger] = "Erro inesperado!"
      end
    end
    redirect_to @exchange
  end

  def invite_accept
    @exchange = Exchange.find(params[:id])
    @user = User.find(params[:user])
    unless !invite_accept_validate?
      @exchange.invites.delete(@user.id)
      @exchange.participants.push(@user.id)
      if @exchange.save
        flash[:success] = "Entrou em: \"" + @exchange.title + "\" com sucesso!"
      else
        flash[:danger] = "Erro inesperado!"
      end
    end
    redirect_to @exchange
  end

  def raffle
    @exchange = Exchange.find(params[:id])
    unless !raffle_validate?
      @exchange.invites = []
      @exchange.requests = []
      raffles = @exchange.gen_raffle
      @exchange.raffled = true
      raffles.each do |raf|
        raf.save
      end
      @exchange.save
      flash[:success] = "Amigo secreto sorteado!"
    end
    redirect_to @exchange
  end

  def reveal
    @exchange = Exchange.find(params[:id])
    unless !reveal_validate?
      @exchange.exposed = true;
      if @exchange.save
        flash[:success] = "Amigo secreto revelado com sucesso!"
      else
        flash[:danger] = "Erro inesperado!"
      end
    end
    redirect_to @exchange
  end

  def invite_all
    @invite_success = []
    @invite_fail = []
    flash[:danger] = ""
    flash[:success] = ""
    @exchange = Exchange.find(params[:id])
    @group = Group.find(params[:group])
    @group.participants.each do |user|
      @user = User.find(user)
      @current_user = current_user
      if invite_send_validate?
        @exchange.invites.push(@user.id)
        if @exchange.save
          @invite_success.push(@user)
        else
          flash[:danger] += "Erro inesperado!"
          @invite_fail.push(@user)
        end
      else
        @invite_fail.push(@user)
      end
    end
    redirect_to @exchange
  end

  private

  def reveal_validate?
    if !@exchange.have_user_as?(@current_user, 'admins')
      flash[:danger] = "Somente administradores do amigo secreto podem revelar o sorteio!"
      return false
    elsif @exchange.exposed?
      flash[:danger] = "Este amigo secreto já foi revelado!"
      return false
    elsif !@exchange.raffled?
      flash[:danger] = "Este amigo secreto ainda não foi sorteado!"
      return false
    end
    return true
  end

  def invite_send_validate?
    if !@exchange.have_user_as?(@current_user, 'admins')
      flash[:danger] = "Você deve ser um administrador do amigo secreto para convidar outras pessoas!"
      return false
    elsif @exchange.have_user_as?(@user, 'participants')
      flash[:danger] += @user.name + " já é um participante deste amigo secreto!"
      return false
    elsif @exchange.have_user_as?(@user, 'invites')
      flash[:danger] += @user.name + " já é um participante deste amigo secreto!"
      return false
    elsif @exchange.raffled?
      flash[:danger] = "Este amigo secreto já foi sorteado!"
      return false
    end
    return true
  end

  def invite_accept_validate?
    if !@exchange.have_user_as?(@current_user, 'invites')
      flash[:danger] = "Você tentou entrar em um amigo secreto que não foi convidado!"
      return false
    elsif @exchange.have_user_as?(@current_user, 'participants')
      flash[:danger] = "Você tentou entrar em um amigo secreto que ja faz parte!"
      return false
    elsif !current_user?(@user)
      flash[:danger] = "Você não pode aceitar convites para outras pessoas!"
      return false
    end
    return true
  end

  def raffle_validate?
    if !@exchange.have_user_as?(@current_user, 'admins')
      flash[:danger] = "Somente administradores do amigo secreto podem fazer o sorteio!"
      return false
    elsif @exchange.participants.count < 4
      flash[:danger] = "O amigo secreto precisa ter pelo menos 4 pessoas!"
      return false
    elsif @exchange.raffled?
      flash[:danger] = "Este amigo secreto já foi sorteado!"
      return false
    end
    return true
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
    params.require(:exchange).permit(:title, :description)
  end
end