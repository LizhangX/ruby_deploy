class User < ActiveRecord::Base
  has_secure_password
  has_many :discussions
  has_many :events
  has_many :attending_events, dependent: :destroy
  has_many :events_joined, through: :attending_events, source: :event
  
  validates :first_name, :last_name, :email, :city, :state, presence: true
  validates :password, on: :create, length: { minimum: 8 }
  validates :email, uniqueness: true, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }
  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end
end
