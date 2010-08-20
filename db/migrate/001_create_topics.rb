class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
    t.column :title, :string  #标题
    t.column :body, :text     #内容
    t.column :created_at, :datetime,:default => Time.now  #发表时间
    t.column :updated_at, :datetime,:default => Time.now  
    t.column :group_id, :integer, :default => 0    #班级ID
    t.column :user_id, :integer, :default => 0     #发表者ID
    t.column :view_counts, :integer, :default => 0 #查看次数
    t.column :reply_counts, :integer, :default => 0 #回复数    
    t.column :top_it, :integer, :default => 0      #是否是公告
    t.column :anonymous, :integer, :default => 0   #匿名发布
    t.column :remote_ip ,:string                   #IP地址
    end
  end

  def self.down
    drop_table :topics
  end
end
