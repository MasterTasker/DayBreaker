class ShowExtraDayByDefault < ActiveRecord::Migration
  def up
    change_column :users, :days_to_show_at_once, :integer, null: false, default: 3
  end

  def down
    change_column :users, :days_to_show_at_once, :integer, null: false, default: 2
  end
end
