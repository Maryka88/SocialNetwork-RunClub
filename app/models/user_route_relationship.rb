# == Schema Information
#
# Table name: user_route_relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  route_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserRouteRelationship < ActiveRecord::Base
  attr_accessible :route_id

  # user_route_relationships con follower (User model)
  belongs_to :follower, class_name: 'User'

  # user_route_relationships con route (Route model)
  belongs_to :route, class_name: 'Route'

  #campi obbligatori della user_route_relationships
  validates :follower_id, presence: true
  validates :route_id, presence: true
end
