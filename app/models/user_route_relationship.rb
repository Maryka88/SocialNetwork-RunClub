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
end
