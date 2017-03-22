class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :title
      t.float :price
      t.string :category
      t.string :description
      t.boolean :status
      t.string :image
      t.string :email
      t.string :phone_number
      t.string :location
      t.integer :user_id

      t.timestamps
    end
  end
end
