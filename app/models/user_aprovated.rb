class UserAprovated < ApplicationRecord
  belongs_to :lot
  belongs_to :user

  validate :user_admin_different?, on: :create

  private 
  
  def user_admin_different?
    if self.lot.user == self.user
      errors.add(:user,"não pode aprovar lotes que criou")
    end
  end
  
end
