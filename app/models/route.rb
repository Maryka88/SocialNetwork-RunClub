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
  attr_accessible :latitude, :longitude, :latitude2, :longitude2, :name, :difficulty

  # ogni itinerario è associato a uno specifico utente
  belongs_to :user

  # ordine decrescente della data di creaz per il get degli itinerari
  default_scope order: 'routes.created_at DESC'

  # ogni itinerario può avere molte user_route_relationships
  # definiamo esplicitamente la chiave esterna e facciamo in modo che se l'itinerario viene eliminato, vengono
  # eliminate anche le sue user_route_relationships
  has_many :user_route_relationships, foreign_key: 'route_id', dependent: :destroy

  # ogni utente può avere molte "reverse" user_route_relationships
  has_many :reverse_user_route_relationships, foreign_key: 'route_id', class_name: 'UserRouteRelationship', dependent: :destroy

  # ogni itinerario può avere molti follower attraverso reverse user_route_relationships
  has_many :followers, through: :reverse_user_route_relationships

  # user_id e coordinate sempre presenti
  validates :user_id, :latitude, :longitude, :latitude2, :longitude2, :presence => true

  # ogni itinerario può avere più comment_routes, e se viene cancellato anche i suoi commenti vengono rimossi
  has_many :comment_routes, dependent: :destroy

  # name sempre presente e unico
  validates :name, :presence => true, :uniqueness => true

  # coordinate uniche (a coppia)
  validates :longitude, :uniqueness => {:scope => :latitude}
  validates :longitude2, :uniqueness => {:scope => :latitude2}

end
