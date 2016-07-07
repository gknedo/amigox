class Raffle < ApplicationRecord

  def self.from_exchange(exchange,user = '')
    ret = Raffle.where(exchange: exchange.id).all
    if(user != '')
      ret = ret.where(user: user.id).all
    end
    return ret
  end
end