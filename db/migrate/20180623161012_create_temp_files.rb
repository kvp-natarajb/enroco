class CreateTempFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_files do |t|
      t.string :attachment

      t.timestamps
    end
  end
end
