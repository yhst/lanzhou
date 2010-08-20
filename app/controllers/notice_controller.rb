class NoticeController < ApplicationController
  before_filter :authorize
  layout "topic"
  def index
    @notices=Topic.find(:all,:conditions => "top_it=1 and group_id = #{session[:group_id]}",:order => "created_at",:limit=>5)
    @topics__pages=Topic.find(:all,:conditions => "top_it=1",:order => "created_at")
    @topic_pages, @topics = paginate_collection @topics__pages, {:page => @params[:page],:per_page => 20,:order => "created_at" }
  end
end
