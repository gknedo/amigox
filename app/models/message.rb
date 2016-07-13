class Message < ApplicationRecord
  def formatted_subject
    if self.subject.blank?
      return 'Sem Assunto'
    else
      return self.subject
    end
  end

  def get_user(to_from)
    return User.find(self.send(to_from))
  end

  def self.for_user(user,unseen = false)
    search = Message.where(to: user.id).order('created_at').reverse_order
    if(unseen)
      search = search.where(seen: false).order('created_at').reverse_order
    end
    return search
  end

  def self.from_user(user)
    return Message.where(from: user.id).order('created_at').reverse_order
  end

  def self.send_exchange_invite(user_from,user_to,exchange)
    message = Message.new
    message.subject = 'Venha participar do meu amigo secreto!'
    message.content = "#{user_from.name} te convidou para participar de seu amigo secreto \"#{exchange.title}\"<br><a href=\"/exchanges/#{exchange.id}\">Clique Aqui</a> para visualizar o convite"
    message.from = user_from.id
    message.to = user_to.id
    message.save
  end

end
