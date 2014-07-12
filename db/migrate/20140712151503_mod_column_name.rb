class ModColumnName < ActiveRecord::Migration
  def change
    rename_column :routes, :address, :difficulty
  end
end
