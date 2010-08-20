class TopicController < ApplicationController
  #layout "index"
  before_filter :authorize
  def index
    @notices=Topic.find(:all,:conditions => "top_it=1 and group_id = #{session[:group_id]}",:order => "created_at",:limit=>5)
    @topics__pages=Topic.find(:all,:conditions => "top_it=0 and group_id = #{session[:group_id]}",:order => "created_at")
    @topic_pages, @topics = paginate_collection @topics__pages, {:page => @params[:page],:per_page => 20,:order => "created_at" }
    @users_links=User.find(:all,:conditions =>"group_id = #{session[:user_id]}  and link_id=1",:order => "created_at")
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @topic_pages, @topics = paginate :topics, :per_page => 10
  end
  
  def mine
    @notices=Topic.find(:all,:conditions => "top_it=1 and user_id = #{session[:user_id]}",:order => "created_at",:limit=>5)
    @topics__pages=Topic.find(:all,:conditions => "user_id=#{session[:user_id]}",:order => "created_at")
    @topic_pages, @topics = paginate_collection @topics__pages, {:page => @params[:page],:per_page => 20,:order => "created_at" }
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.remote_ip=@request.remote_ip
    @topic.reply_counts=0
    @topic.view_counts=0
    if (@topic.top_it==1)
      @topic.top_it=1  
    else 
      @topic.top_it=0
    end
    
    if (@topic.anonymous==1)
      @topic.anonymous=1  
    else 
      @topic.anonymous=0
    end
    
    if @topic.save
      flash[:notice] = '恭喜,恭喜,留言成功.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      flash[:notice] = '编辑成功咯...'
      redirect_to :action => 'show', :id => @topic
    else
      render :action => 'edit'
    end
  end

  def destroy
    Topic.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
