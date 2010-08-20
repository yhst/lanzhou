class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
    t.column :title, :string          #班级名称
    t.column :slogan, :string         #班级口号
    t.column :description, :text      #班级简介
    t.column :created_at, :datetime,:default => Time.now  #创建时间
    t.column :updated_at, :datetime,:default => Time.now
    t.column :admin_id, :integer, :default => 0 #管理员
    t.column :users_counts, :integer, :default => 0
    t.column :announcements_counts, :integer, :default => 0
    t.column :topics_counts, :integer, :default => 0     #发表留言总数
    t.column :photos_counts, :integer, :default => 0     #上传图片言总数
    t.column :view_counts, :integer, :default => 0     #访问次数
    t.column :group_pic_url,:string   #班级个性图片
    end
  end

  def self.down
    drop_table :groups
  end
end
