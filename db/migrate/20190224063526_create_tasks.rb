class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :catagory_id
      t.string :name
      t.date :due_date
      t.string :status, default: 'todo'

      t.timestamps
    end
  end
end
