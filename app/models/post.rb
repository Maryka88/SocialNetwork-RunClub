# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  # solo content e title sono accessibili, per evitare eventuali associaz user-post manuali o sbagliate
  attr_accessible :content, :title

  # ogni post è associato a uno specifico utente
  belongs_to :user

  # ordine decrescente della data di creaz per il get dei posts
  default_scope order: 'posts.created_at DESC'

  # user_id sempre presente
  validates :user_id, presence: true

  # title sempre presente e minimo 5 caratteri
  validates :title, presence: true, length: {minimum: 5}

  # content sempre presente e massimo 500 caratteri
  validates :content, presence: true, length: {maximum: 500}

  # prendo i post dell'utente più quelli scritti dagli utenti che segue
  def self.from_users_followed_by(user)
      followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'

       where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end


end
