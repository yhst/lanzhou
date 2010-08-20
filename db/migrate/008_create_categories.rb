class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
    t.column :group_id, :integer, :default => 0  #班级ID
    t.column :name, :string  #相册分类名
    t.column :description, :string  #相册分类描述
    t.column :photos_count, :integer, :default => 0 #照片数
    end
  end

  def self.down
    drop_table :categories
  end
end
