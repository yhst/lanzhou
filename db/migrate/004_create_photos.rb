class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
    t.column :group_id, :integer, :default => 0 #归属班级
    t.column :user_id, :integer, :default => 0  #上传用户
    t.column :view_counts, :integer, :default => 0 #观看次数
    t.column :created_at, :datetime,:default => Time.now #上传时间
    t.column :updated_at, :datetime,:default => Time.now
    t.column :reply_counts, :integer, :default => 0 #回复数    
    t.column :flowers_counts, :integer, :default => 0 #鸡蛋数
    t.column :eggs_counts, :integer, :default => 0  #鲜花数
    t.column :title, :string          #标题
    t.column :category_id, :integer , :default => 0   #相册分类
    t.column :description, :text     #照片介绍
    end
  end

  def self.down
    drop_table :photos
  end
end
