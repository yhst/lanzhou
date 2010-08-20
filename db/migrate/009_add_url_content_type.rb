class AddUrlContentType < ActiveRecord::Migration
  def self.up
    add_column :photos, :url, :string  #图片绝对路径
    add_column :photos, :simple_path, :string #相对路径
    add_column :photos, :content_type, :string #类型
  end

  def self.down
    remove_column :photos, :url
    remove_column :photos, :simple_path
    remove_column :photos, :content_type
  end
end
