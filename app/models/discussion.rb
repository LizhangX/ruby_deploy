class Discussion < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :event, required: true

  validates :comment, presence:true
end
