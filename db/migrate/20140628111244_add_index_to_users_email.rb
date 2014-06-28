class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    # per assicurare univocità campo email
    add_index :users, :email, unique: true
  end
end
