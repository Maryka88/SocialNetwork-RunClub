# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  # relationship con follower ( User model)
  belongs_to :follower, class_name: 'User'

  # relationship con followed ( User model)
  belongs_to :followed, class_name: 'User'

  #campi obbligatori della relationship
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
