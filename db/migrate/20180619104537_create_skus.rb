class CreateSkus < ActiveRecord::Migration[5.0]
  def change
    create_table :skus do |t|
      t.integer :denomination
      t.string :combination
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
