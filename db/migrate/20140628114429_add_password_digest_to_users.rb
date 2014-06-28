class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    #per autenticazione con pwd crittografata
    add_column :users, :password_digest, :string
  end
end
