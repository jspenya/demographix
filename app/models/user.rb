class User < ApplicationRecord
  devise :registerable, :recoverable, :rememberable,
         :validatable, :database_authenticatable, :authentication_keys => [:username]

  validates :username, :email, uniqueness: true
  validates :username, :first_name, :last_name, :birth_date, presence: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
