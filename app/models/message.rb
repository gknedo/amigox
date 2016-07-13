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
    message.content = "#{user_from.name} te convidou para participar de seu amigo secreto \"#{exchange.title}\"<br>#{href_exchange(exchange,"Clique Aqui")} para visualizar o convite"
    message.from = user_from.id
    message.to = user_to.id
    message.save
  end

  def self.send_exchange_raffle(user_from,user_to,exchange)
    message = Message.new
    message.subject = exchange.title + " foi sorteado!"
    message.content = "O amigo secreto \"#{exchange.title}\" foi sorteado<br>#{href_exchange(exchange,"Clique Aqui")} para conferir com quem você saiu!"
    message.from = user_from.id
    message.to = user_to.id
    message.save
  end

  def self.send_exchange_reveal(user_from,user_to,exchange)
    message = Message.new
    message.subject = exchange.title + " foi revelado!"
    message.content = "O amigo secreto \"#{exchange.title}\" foi revelado<br>#{href_exchange(exchange,"Clique Aqui")} para você poder conferir com quem todos saíram!"
    message.from = user_from.id
    message.to = user_to.id
    message.save
  end

  def self.send_group_invite(user_from,user_to,group)
    message = Message.new
    message.subject = 'Venha participar do meu grupo!'
    message.content = "#{user_from.name} te convidou para participar de seu amigo secreto \"#{group.title}\"<br>#{href_group(group,"Clique Aqui")} para visualizar o convite"
    message.from = user_from.id
    message.to = user_to.id
    message.save
  end

  private
  def self.href_group(group,str)
    return "<a href=\"/groups/#{group.id}\">#{str}</a>"
  end

end
