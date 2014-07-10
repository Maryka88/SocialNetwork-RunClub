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
#  address    :string(255)
#

class Route < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :address

  belongs_to :user, :foreign_key => 'user_id'

  validates :latitude, :longitude, :name, presence: :true

end
