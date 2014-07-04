class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    # indici
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # indice per unicità coppia indici precedenti.
    add_index :relationships, [ :follower_id, :followed_id ], unique: true
  end
end
