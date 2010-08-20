class SingleFile < ActiveRecord::Base
validates_format_of :content_type,
                    :with=>/^image/,
                    :message=>"只能上传图片..."

   def self.save(photo)
    @group_id=photo['group_id']
    @uploaded_file = photo['file']
    @category_id =photo['category_id']
    @user_id = photo['user_id']
    @filename = sanitize_filename(@uploaded_file.original_filename)
    ##
    if !File.exists?(File.dirname(self.path))
      FileUtils.mkdir_p(File.dirname(self.path))
    end
    if @uploaded_file.instance_of?(Tempfile)
      FileUtils.copy(@uploaded_file.local_path, self.path)
    else
      File.open(self.path, "wb") { |f| f.write(@uploaded_file.read) }
    end
    #write_attribute(:file, self.simple_path)
    @user=User.find_by_id(@user_id)
    @user.update_attribute('photo_count', 1 + @user.photo_count)
    @filename 
  end
  


  def after_destroy
    if File.exists?(self.file)
      File.delete(self.file)
      Dir.rmdir(File.dirname(self.file))
    end
  end
  
  def self.content_type
  @uploaded_file.content_type.chomp
  end

  def self.simple_path
    "upload/pic/#{@group_id}/#{@category_id}/#{@filename}"
  end

  def self.path
    File.expand_path("#{RAILS_ROOT}/upload/pic/#{@user_id}/#{@filename}")
  end
  
  def self.path
    File.expand_path("#{RAILS_ROOT}/upload/pic/#{@group_id}/#{@category_id}/#{@filename}")
  end

private
  def self.sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name) 
    # replace all none alphanumeric, underscore or perioids with underscore
    just_filename.gsub(/[^\w\.\_]/,'_') 
  end
end

