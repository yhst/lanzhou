class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
    t.column :title,:string #标题
    t.column :body,:text    #内容
    t.column :photo_id,:integer  #照片ID
    t.column :topic_id,:integer  #留言ID
    t.column :user_id,:integer   #回复者ID
    t.column :create_at ,:datetime #回复时间
    end
  end

  def self.down
    drop_table :comments
  end
end
