class AddUserPreferences < ActiveRecord::Migration
  def change
    add_column :users, :days_to_show_at_once, :integer, null: false, default: 2
    add_column :users, :max_hours_per_day,    :decimal, null: false, default: 8.0,  scale: 2, precision: 10
    add_column :users, :min_hours_per_task,   :decimal, null: false, default: 0.25, scale: 2, precision: 10
    add_column :users, :max_hours_per_task,   :decimal, null: false, default: 4.0,  scale: 2, precision: 10
  end
end
