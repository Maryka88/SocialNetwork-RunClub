class CreateCommentRoutes < ActiveRecord::Migration
  def change
    create_table :comment_routes do |t|
      t.string :content
      t.integer :user_id
      t.integer :route_id

      t.timestamps
    end

    # index per associare commento a un itinerario dato, in ordine inverso
    add_index :comment_routes, [:route_id, :created_at]
  end
end
