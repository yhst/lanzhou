class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
    t.column :title, :string  #标题
    t.column :body, :text     #内容
    t.column :created_at, :datetime,:default => Time.now  #发送时间
    t.column :viewed_at, :datetime,:default => Time.now   #查看时间
    t.column :ccer_id, :integer, :default => 0              #抄送给ID
    t.column :owner_id, :integer, :default => 0           #所有者ID
    t.column :from_id, :integer, :default => 0            #发送者ID
    t.column :viewed_it, :integer, :default => 0          #是否已查阅
    t.column :replyed_it, :integer, :default => 0         #是否已回复
    t.column :remote_ip ,:string                          #IP地址
    end
  end

  def self.down
    drop_table :messages
  end
end
