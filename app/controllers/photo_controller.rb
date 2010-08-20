class PhotoController < ApplicationController
  before_filter :authorize
  layout "topic"
  def index
    @photo=Photo.find(:first,:order => "created_at")
    @photos__pages=Photo.find(:all,:order => "created_at")
    @photo_pages, @photos = paginate_collection @photos__pages, {:page => @params[:page],:per_page => 10,:order => "created_at" }
  end
  
  def mine
    @photo=Photo.find(:first,:conditions => "user_id=#{session[:user_id]}",:order => "created_at")
    @photos__pages=Photo.find(:all,:conditions => "user_id=#{session[:user_id]}",:order => "created_at")
    @photo_pages, @photos = paginate_collection @photos__pages, {:page => @params[:page],:per_page => 10,:order => "created_at" }
  end
  
  def new
  @photo = Photo.new
  end
  
  def upload 
    @photo = Photo.new(params[:photo])
    @photo.view_counts=0
    @photo.reply_counts=0
    filename = SingleFile.save(@params["photo"])
    @photo.url= SingleFile.path
    @photo.simple_path= SingleFile.simple_path
    @photo.content_type= SingleFile.content_type
    if @photo.save
      flash[:notice] = '恭喜,恭喜,照片上传成功.'
      redirect_to :action => "index"
    else
      redirect_to :action => 'new'
    end
  end
  
#  def save
#  @picture = Picture.new(params[:picture])
#  if @picture.save
#  redirect_to(:action => 'show' , :id => @picture.id)
#  else
#  render(:action => :get)
#  end
#  end
  def show
  @photo= Photo.find_by_id(params[:id])
  end
  
end
