class CreateUserRouteRelationships < ActiveRecord::Migration
  def change
    create_table :user_route_relationships do |t|
      t.integer :follower_id
      t.integer :route_id

      t.timestamps
    end

    # indici
    add_index :user_route_relationships, :follower_id
    add_index :user_route_relationships, :route_id
    # un utente può seguire un itinerario una sola volta
    add_index :user_route_relationships, [ :follower_id, :route_id ], unique: true
  end
end
