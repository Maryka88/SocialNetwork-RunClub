class AddDistanceAndTimerouteToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :distance, :integer
    add_column :routes, :type_distance, :string
    add_column :routes, :timeroute, :integer
    add_column :routes, :type_timeroute, :string
  end
end
