# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# modello dell'utente
class User < ActiveRecord::Base
  attr_accessible :email, :name

  #name sempre presente e con lunghezza massima di 50 caratteri
  validates :name, :presence => true, :length => { :maximum => 50 }

  #formato valido per email con regex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i

  validates :email, :presence => true, :uniqueness => { case_sensitive: false }, :format => { with: VALID_EMAIL_REGEX }
end
