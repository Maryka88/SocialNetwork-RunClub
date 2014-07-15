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
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

# modello dell'utente
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  #per usare sistema di autenticazione di Rails
  has_secure_password

  # ogni utente può inviare/ricevere messaggi privati (graziee alla gemma simple-private-messages )
  has_private_messages

  # ogni utente può avere più post, e se viene cancellato anche i suoi post vengono rimossi
  has_many :posts, dependent: :destroy

  # ogni utente può avere più itinerari, e se viene cancellato anche i suoi itinerari vengono rimossi
  has_many :routes, dependent: :destroy

  # ogni utente può avere più immagini, e se viene cancellato anche le sue immagini vengono rimosse
  has_many :pictures, dependent: :destroy

  # ogni utente può avere più comment_routes, e se viene cancellato anche i suoi commenti vengono rimossi
  has_many :comment_routes, dependent: :destroy

  # ogni utente può avere molte relationship
  # definiamo esplicitamente la chiave esterna e facciamo in modo che se l'utente viene eliminato, vengono
  # eliminate anche le sue relationship
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy

  # ogni utente può avere molte user_route_relationships
  # definiamo esplicitamente la chiave esterna e facciamo in modo che se l'utente viene eliminato, vengono
  # eliminate anche le sue user_route_relationships
  has_many :user_route_relationships, foreign_key: 'follower_id', dependent: :destroy

  # ogni utente può avere molti followed users, attraverso la tabella relationships
  # siccome followed_users non esiste, indichiamo a Rails la colonna corretta della tab relat. (con source: "followed_id")
  has_many :followed_users, through: :relationships, source: :followed

  # ogni utente può avere molte "reverse" relationships
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy

  #ogni utente può avere molti followers, attraverso reverse relationships
  has_many :followers, through: :reverse_relationships

  # downcase della mail prima del salvataggio dell'utente
  before_save { |user| user.email = email.downcase }
  # chiamo il metodo privato create_remember_token prima del salvataggio dell'utente
  before_save :create_remember_token

  #name sempre presente e con lunghezza massima di 50 caratteri
  validates :name, :presence => true, :length => { :maximum => 50 }

  #formato valido per email con regex
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i

  #email sempre presente, unica e con controllo formato
  validates :email, :presence => true, :uniqueness => { case_sensitive: false }, :format => { with: VALID_EMAIL_REGEX }

  #password di minimo 6 caratteri, le due password sono obbligatorie e validitate da has_secure_password
  validates :password, :length => { :minimum => 6}

  # sta seguendo l'utente dato?
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  # segui l'utente
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # non seguire più l'uutente
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end


  # sta seguendo l'itinerario dato?
  def r_following?(r_route)
    user_route_relationships.find_by_route_id(r_route.id)
  end

  # segui l'itinerario
  def r_follow!(r_route)
    user_route_relationships.create!(route_id: r_route.id)
  end

  # non seguire più l'itinerario
  def r_unfollow!(r_route)
    user_route_relationships.find_by_route_id(r_route.id).destroy
  end

  # prendo i post per visualizzarli nella bacheca
  def feed
      Post.from_users_followed_by(self)
  end

  # meotodo privato
  private

  def create_remember_token
  # creo stringa random per remember token univoco
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
