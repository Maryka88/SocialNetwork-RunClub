# == Schema Information
#
# Table name: pictures
#
#  id               :integer          not null, primary key
#  url              :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pic_file_name    :string(255)
#  pic_content_type :string(255)
#  pic_file_size    :integer
#  pic_updated_at   :datetime
#

class Picture < ActiveRecord::Base
  attr_accessible :url, :pic
  #paperclip
  has_attached_file :pic, :styles => { :medium => "80x80>", :small => "52x52>", :thumb => "30x30>" }

  # ogni immagine è associata a uno specifico utente
  belongs_to :user

  # user_id sempre presente
  validates :user_id, :presence => true

end
