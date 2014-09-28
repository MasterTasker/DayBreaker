class AddCompletionHistoryToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :completed_on,        :date
    add_column :tasks, :old_completed_hours, :decimal, null: false, default: 0.0, scale: 2, precision: 10
  end
end
