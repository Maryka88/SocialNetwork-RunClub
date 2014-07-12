class AddSecondLatLongToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :latitude2, :float
    add_column :routes, :longitude2, :float
  end
end
