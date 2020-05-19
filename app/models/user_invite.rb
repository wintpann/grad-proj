class UserInvite < ApplicationRecord

  def self.create_invite
    self.create(invite: SecureRandom.urlsafe_base64)
  end

  def self.exists?(invite)
    self.all.each do |i|
      return true if i.invite==invite
    end
    return false
  end

end
