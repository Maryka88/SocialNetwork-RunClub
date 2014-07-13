# == Schema Information
#
# Table name: comment_routes
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  route_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CommentRoute < ActiveRecord::Base
  attr_accessible :content, :route_id, :user_id

  # ogni commento è collegato a uno specifico utente
  belongs_to :user

  # ogni commento è collegato a uno specifico itinerario
  belongs_to :route

  # ordine decrescente della data di creaz per il get dei commenti
  default_scope order: 'comment_routes.created_at DESC'

  # user_id e route_id sempre presenti
  validates :user_id, :route_id, presence: true

  # content deve essere sempre presente e di minimo 1 carattere e massimo 500 caratteri
  validates :content, presence: true, length: {maximum: 500, minumum:1}
end
