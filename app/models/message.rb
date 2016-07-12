class Message < ApplicationRecord
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

end
