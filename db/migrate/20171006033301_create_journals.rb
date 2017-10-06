class CreateJournals < ActiveRecord::Migration[5.1]
  def change
    create_table :journals do |t|
      t.string :content
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
