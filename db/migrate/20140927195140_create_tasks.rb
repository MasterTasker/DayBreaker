class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :name
      t.uuid   :user_id

      t.timestamps
    end
  end
end
