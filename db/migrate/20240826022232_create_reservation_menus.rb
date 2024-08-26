class CreateReservationMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_menus do |t|
      t.references :reservation, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
