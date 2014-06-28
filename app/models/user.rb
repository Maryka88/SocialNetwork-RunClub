# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

# modello dell'utente
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  #per usare sistema di autenticazione di Rails
  has_secure_password

  #name sempre presente e con lunghezza massima di 50 caratteri
  validates :name, :presence => true, :length => { :maximum => 50 }

  #formato valido per email con regex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i

  #email sempre presente, unica e con controllo formato
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }, :format => { with: VALID_EMAIL_REGEX }

  #password di minimo 6 caratteri, le due password sono obbligatorie e validitate da has_secure_password
  validates :password, :length => { :minimum => 6}
end
