class Exchange < ApplicationRecord
  validates :admins, presence: true, length: {minimum: 1}

  def have_user_as?(user, field)
    self.send(field).include?(user.id)
  end

  def gen_raffle
    raffles = []
    remaining_to_send = participants.clone
    remaining_to_receive = participants.clone
    while remaining_to_send.length > 0 do
      to_send = remaining_to_send.first
      to_receive = remaining_to_receive.sample
      if to_send != to_receive
        remaining_to_send.delete(to_send)
        remaining_to_receive.delete(to_receive)
        raffles.push(Raffle.new(exchange: self.id, user: to_send, gift_to: to_receive))
      elsif remaining_to_send.size == 1
        raffles = []
        remaining_to_send = participants.clone
        remaining_to_receive = participants.clone
      end
    end
    return raffles
  end

  def self.exchanges_administered_by(user)
    Exchange.where("'" + user.id.to_s+"' = ANY(admins)")
  end

  def self.exchanges_to_invite(current_user, user_to_invite)
    exchanges = []
    exchanges_administered_by(current_user).each do |exchange|
      unless exchange.have_user_as?(user_to_invite, 'participants') || exchange.have_user_as?(user_to_invite, 'invites') || exchange.raffled?
        exchanges.push(exchange)
      end
    end
    return exchanges
  end

  def self.exchanges_as_guest(user)
    exchanges = []
    Exchange.all.each do |exchange|
      if exchange.have_user_as?(user, 'invites')
        exchanges.push(exchange)
      end
    end
    return exchanges
  end
end
