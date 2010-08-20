# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
#require 'RMagick'
class ApplicationController < ActionController::Base
 before_filter :configure_charsets
 before_filter :overall
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_byelo_session_id'

    def configure_charsets
      response.headers["Content-Type"] = "text/html; charset=utf-8"
      # Set connection charset. MySQL 4.0 doesn’t support this so it
      # will throw an error, MySQL 4.1 needs this
      suppress(ActiveRecord::StatementInvalid) do
        ActiveRecord::Base.connection.execute `SET NAMES UTF8`
      end
    end

    def overall
    @users_links=User.find(:all,:conditions =>"1=1",:order => "created_at")
    @notices=Topic.find(:all,:conditions => "top_it=1",:order => "created_at",:limit => 5)
    @groups=Group.find(:all,:order => "created_at")
    @groups_hots=Group.find(:all,:order => "topics_counts")
    end

    #身份验证
   def authorize
    unless session[:user_id]
      session[:jumpto] = request.parameters
      flash[:notice]="� 所做得操作需要登录，请登录..!"
      redirect_to(:controller=>"/index",:action=>"login")
    end
   end

   #管理员身份验证
   def authorize_admin
    unless session[:user_id] and session[:user_group_id] ==0
      flash[:notice]="� 不是管理员，没有权限操作..!"
      redirect_to(:controller=>"index",:action=>"login")
    end
   end

     #公用方法 转向首页
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to(:action => 'index')
  end


    #分页功能函数
  def paginate_collection(collection, options = {})
    default_options = {:per_page => 10, :page => 1}
    options = default_options.merge options
    pages = Paginator.new self, collection.size, options[:per_page], options[:page]
    first = pages.current.offset
    last = [first + options[:per_page], collection.size].min
    slice = collection[first...last]
    return [pages, slice]
  end

  def picture
  pic_path=Photo.find_by_id(@params[:id]).url
###
#if (pic_path)
#clown = Magick::Image.read(pic_path).first
#clown.crop_resized!(80, 80, Magick::NorthGravity)
#clown.write(pic_path)
#else
#clown = Magick::Image.read("#{RAILS_ROOT}/public/images/photo.gif").first
#clown.crop_resized!(80, 80, Magick::NorthGravity)
#clown.write(pic_path)
#end
##
    if (pic_path)
    pic = File.open(pic_path)
    pic.binmode
    #@picture = Picture.find(params[:id])
    send_data(pic.read,{:filename=>'1.jpg',:type=>Photo.find_by_id(@params[:id]).content_type,:disposition=>"inline"})
    else
    pic = File.open("#{RAILS_ROOT}/public/images/rails")
    pic.binmode
    #@picture = Picture.find(params[:id])
    send_data(pic.read,{:filename=>'1.jpg',:type=>'png',:disposition=>"inline"})
   end
  end
end
