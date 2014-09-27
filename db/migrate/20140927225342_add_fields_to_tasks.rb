class AddFieldsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :estimated_hours, :decimal,   null: false, default: 0.0, scale: 2, precision: 10
    add_column :tasks, :completed_hours, :decimal,   null: false, default: 0.0, scale: 2, precision: 10
    add_column :tasks, :due_at,          :timestamp
  end
end
