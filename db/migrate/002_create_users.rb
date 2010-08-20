class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
    t.column :login_name, :string  #登录名
    t.column :display_name, :string#现实名
    t.column :hashed_pass,:string  #密码
    t.column :email,:string     #油箱
    t.column :mobile,:string    #移动号码
    t.column :address,:string   #地址
    t.column :birthday,:date    #生日
    t.column :sex,:integer      #性别
    t.column :state,:integer, :default => 0     #用户状态 
    t.column :pic_url,:string   #个性头像地址
    t.column :personality,:text #个性签名
    t.column :im,:string        #即时通讯
    t.column :website, :string,:default => "http://"   #个人站点
    t.column :link_id, :integer, :default => 0         #是否显示
    t.column :user_group_id, :integer, :default => 1   #用户等级（管理员，成员，贵宾）
    t.column :group_id, :integer, :default => 0        #班级ID
    t.column :topic_count, :integer, :default => 0     #发表留言数
    t.column :photo_count, :integer, :default => 0     #上传图片言数
    t.column :created_at, :datetime,:default => Time.now #注册时间
    t.column :updated_at, :datetime,:default => Time.now #更新时间
    end
  end

  def self.down
    drop_table :users
  end
end
