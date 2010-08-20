class Admin::SetController < ApplicationController
  before_filter :authorize
  layout "topic"
  
  def index
  @group = Group.find(session[:group_id])
  end
  
  def update_class
    @group = Group.find(session[:group_id])
    if @group.update_attributes(params[:group])
      flash[:notice] = '班级资料修改成功...'
      redirect_to :controller=>"/topic",:action => 'index'
    else
      render :action => 'index'
    end
  end
  
end
