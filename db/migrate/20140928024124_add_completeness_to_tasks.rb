class AddCompletenessToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :completed, :boolean, null: false, default: false
  end
end
