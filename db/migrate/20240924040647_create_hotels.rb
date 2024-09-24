class CreateHotels < ActiveRecord::Migration[7.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :max_rooms

      t.timestamps
    end
  end
end
