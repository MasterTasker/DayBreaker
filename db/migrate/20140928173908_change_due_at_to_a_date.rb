class ChangeDueAtToADate < ActiveRecord::Migration
  def up
    change_column :tasks, :due_at, :date
  end
  def down
    change_column :tasks, :due_at, :datetime
  end
end
