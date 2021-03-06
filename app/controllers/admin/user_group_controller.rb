class Admin::UserGroupController < ApplicationController
  before_filter :authorize
  layout "topic"
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @user_group_pages, @user_groups = paginate :user_groups, :per_page => 10
  end

  def show
    @user_group = UserGroup.find(params[:id])
  end

  def new
    @user_group = UserGroup.new
  end

  def create
    @user_group = UserGroup.new(params[:user_group])
    if @user_group.save
      flash[:notice] = '分类创建成功...'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @user_group = UserGroup.find(params[:id])
  end

  def update
    @user_group = UserGroup.find(params[:id])
    if @user_group.update_attributes(params[:user_group])
      flash[:notice] = '分类编辑成功...'
      redirect_to :action => 'show', :id => @user_group
    else
      render :action => 'edit'
    end
  end

  def destroy
    UserGroup.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
