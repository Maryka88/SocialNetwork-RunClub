class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    # aggiungo colonna remember token a users
    add_column :users, :remember_token, :string
    # la rendo indice
    add_index :users, :remember_token
  end
end
