# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Route < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name

  validates :latitude, :longitude, :name, presence: :true
end
