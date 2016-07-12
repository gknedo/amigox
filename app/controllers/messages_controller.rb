class MessagesController < ApplicationController
  before_action :logged_in_user

  def new
  end

  def create
    @message = Message.new(user_params.merge(from: current_user.id, seen: false))
    if @message.save
      flash[:success] = "Mensagem enviada com sucesso."
      redirect_to @message.get_user('to')
    end
  end

  def show
    @message = Message.find(params[:id])
    unless show_validate?
      redirect_to root_path
    end
    if (current_user.id == @message.to)
      @message.seen = true
      @message.save
    end
  end

  def inbox
    @messages = Message.for_user(current_user)
  end

  def sent
    @messages = Message.from_user(current_user)
  end

  #Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Por favor, esteja logado para visualizar esse conteúdo"
      redirect_to login_path
    end
  end

  private

  def show_validate?
    from = User.find(@message.from)
    to = User.find(@message.to)
    if current_user?(from) || current_user?(to)
      return true
    else
      return false
    end
  end

  def user_params
    params.require(:message).permit(:to, :content, :subject)
  end
end
