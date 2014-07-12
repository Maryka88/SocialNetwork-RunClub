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
#  difficulty :string(255)
#  latitude2  :float
#  longitude2 :float
#

class Route < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :user_id, :latitude2, :longitude2, :name, :difficulty

  belongs_to :user, :foreign_key => 'user_id'

  validates :latitude, :longitude, :latitude2, :longitude2, :presence => true
  validates :name, :presence => true, :uniqueness => true

  validates :longitude, :uniqueness => {:scope => :latitude}
  validates :longitude2, :uniqueness => {:scope => :latitude2}

end
