# modello dell'utente
class User < ActiveRecord::Base
  attr_accessible :email, :name
end
