class CreateTaskItems < ActiveRecord::Migration[5.1]
  def change
    create_table :task_items do |t|
      t.string :content
      t.date :finished_at
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
