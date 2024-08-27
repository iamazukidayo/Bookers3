class AddDurationToMenus < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :duration, :integer
  end
end
