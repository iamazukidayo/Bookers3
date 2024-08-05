class AddColor < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :color, :integer, default: 0, null: false
  end
end
