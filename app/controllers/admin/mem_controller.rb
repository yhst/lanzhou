class Admin::MemController < ApplicationController
  before_filter :authorize
  layout "topic"
  
  def index  
    @notices=Topic.find(:all,:conditions => "top_it=1 and group_id = #{session[:group_id]}",:order => "created_at",:limit=>5)
    @mems__pages=User.find(:all,:conditions =>"group_id = #{session[:group_id]}",:order => "created_at")
    @user_pages, @mems = paginate_collection @mems__pages, {:page => params[:page],:per_page => 20,:order => "created_at" }
  end
end
