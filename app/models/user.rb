class User < ApplicationRecord
  include Targetable

  TARGETABLE_CHARACTERISTICS = %w[age gender]

  GENDERS = %w[
    Agender Female Male Genderqueer\ or\ Genderfluid
    Non-binary Questioning\ or\ unsure Two-spirit
  ].freeze

  devise :registerable, :recoverable, :rememberable,
         :validatable, :database_authenticatable, :authentication_keys => [:username]

  validates :username, :email, uniqueness: true
  validates :username, :first_name, :last_name, :birth_date, presence: true

  attr_reader :age

  def age
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

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
