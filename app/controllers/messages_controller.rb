class MessagesController < ApplicationController
  def new
  end

  def create
    @message = Message.new(user_params.merge(from: current_user.id, seen:false ))
    if @message.save
      flash[:success] = "Mensagem enviada com sucesso."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:message).permit(:to,:content)
  end
end
