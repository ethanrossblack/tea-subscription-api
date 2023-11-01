class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :title, null: false
      t.float :price, null: false
      t.integer :frequency, null: false

      t.timestamps
    end
  end
end
