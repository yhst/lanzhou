class Photo < ActiveRecord::Base
  belongs_to :user
  validates_format_of :content_type,
                      :with=>/^image/,
                      :message=>"只能上传图片..."
                    
   def file=(photo_field)
   self.save photo_field
   end
#  photo = SingleFile.save(file)
#  self.name = base_part_of(picture_field.original_filename)
##  self.content_type = picture_field.content_type.chomp
##  self.data = picture_field.read
#  end
#  
#  def base_part_of(file_name)
#  name = File.basename(file_name)
#  name.gsub(/[^\w._-]/, '' )
#  end
  
   def self.save(photo)
    @group_id=photo['group_id']
    @uploaded_file = photo['file']
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
    #@user=User.find_by_id(@user_id)
   # @user.update_attributes(:pic_url=> self.path,:simple_path=>self.simple_path,:content_type=>@uploaded_file.content_type)
    #  
  end
  


  def after_destroy
    if File.exists?(self.file)
      File.delete(self.file)
      Dir.rmdir(File.dirname(self.file))
    end
  end

  def self.simple_path
    "upload/pic/#{@user_id}/#{@filename}"
  end

  def self.path
    File.expand_path("#{RAILS_ROOT}/upload/pic/#{@user_id}/#{@filename}")
  end

private
  def self.sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name) 
    # replace all none alphanumeric, underscore or perioids with underscore
    just_filename.gsub(/[^\w\.\_]/,'_') 
  end
  
end
