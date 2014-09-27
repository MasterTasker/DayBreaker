class MoveUsersToUserUuids < ActiveRecord::Migration
  
  def up
    remove_column :users, :id
    add_column :users, :id, :uuid, default: 'uuid_generate_v1()'
  end

  def down
    remove_column :users, :id
    add_column :users, :id, :primary_key
  end

end
