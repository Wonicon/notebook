class AddDateToJournals < ActiveRecord::Migration[5.1]
  def change
    add_column :journals, :date, :date
  end
end
