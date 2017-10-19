class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :name
      t.string :file
      t.string :source

      t.timestamps
    end
  end
end
