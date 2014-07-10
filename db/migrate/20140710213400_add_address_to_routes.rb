class AddAddressToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :address, :string
  end
end
