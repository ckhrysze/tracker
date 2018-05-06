class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: :uuid do |t|
      t.text :description
      t.string :name
      t.uuid :project_id
      t.integer :status, default: 10

      t.timestamps null: false
    end

    add_foreign_key :tasks, :projects
  end
end
