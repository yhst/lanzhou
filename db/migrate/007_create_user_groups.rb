class CreateUserGroups < ActiveRecord::Migration
  def self.up
    create_table :user_groups do |t|
    t.column :group_id, :integer, :default => 0
    t.column :name, :string  #人群分类名
    t.column :description, :string  #人群分类描述
    t.column :users_count, :integer, :default => 0 #用户数
    end
  end

  def self.down
    drop_table :user_groups
  end
end
