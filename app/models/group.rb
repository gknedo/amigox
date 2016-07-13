class Group < ApplicationRecord
  def have_user_as?(user, field)
    self.send(field).include?(user.id)
  end

  def self.groups_to_invite(current_user, user_to_invite)
    groups = []
    groups_administered_by(current_user).each do |group|
      unless group.have_user_as?(user_to_invite, 'participants') || group.have_user_as?(user_to_invite, 'invites')
        groups.push(group)
      end
    end
    return groups
  end

  def self.groups_administered_by(user)
    Group.where("'" + user.id.to_s+"' = ANY(admins)")
  end

  def self.groups_as_guest(user)
    groups = []
    Group.all.each do |group|
      if group.have_user_as?(user, 'invites')
        groups.push(group)
      end
    end
    return groups
  end
end
