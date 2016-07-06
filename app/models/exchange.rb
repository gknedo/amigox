class Exchange < ApplicationRecord
  validates :admins, presence: true, length: {minimum: 1}

  def have_user_as?(user,field)
    self.send(field).include?(user.id)
  end

  def self.exchanges_administered_by(user)
    Exchange.where("'" + user.id.to_s+"' = ANY(admins)")
  end

  def self.exchanges_to_invite(current_user,user_to_invite)
    exchanges = []
    exchanges_administered_by(current_user).each do |exchange|
      unless exchange.have_user_as?(user_to_invite,'participants') || exchange.have_user_as?(user_to_invite,'invites') || exchange.raffled?
        exchanges.push(exchange)
      end
    end
    return exchanges
  end

  def self.exchanges_as_guest(user)
    exchanges = []
    Exchange.all.each do |exchange|
      if exchange.have_user_as?(user,'invites')
        exchanges.push(exchange)
      end
    end
    return exchanges
  end
end
