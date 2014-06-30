class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.integer :user_id

      t.timestamps
    end

    # index per associare post a un utende dato, in ordine inverso
    add_index :posts, [:user_id, :created_at]
  end
end
