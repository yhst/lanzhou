require "digest/sha1"
class IndexController < ApplicationController
  layout "index"
  
  def index
   #@topics=Topic.find(:all,:order=>"created_at DESC",:limit=>"5")
    @topic_pages, @topics = paginate :topics, :per_page => 10
  end


  def register
    if request.get?
      @user=User.new
    else
      #@user = User.new(@params[:user])
      @user = User.new(params[:user])
      @user.created_at =Time.now
      @user.topic_count =0
      if User.count ==0
        @user.user_group_id = -1 
      else
        @user.user_group_id =1
      end
      if @user.save
        MailRobot::deliver_confirmation_email(@user, confirmation_hash(@user.login_name))
        redirect_to_index("User #{@user.display_name} created")
      end
    end
  end
  
  def login
      if request.get?
        session[:user_id] = nil
        session[:user_group_id] = nil
        session[:group_id] = nil
        @user = User.new
      else
        @user=User.new(params[:user])
        logged_in_user = @user.try_to_login
        if logged_in_user
          session[:user_id]=logged_in_user.id
          session[:user_group_id] = logged_in_user.user_group_id
          session[:group_id] = logged_in_user.group_id
          flash[:notic] = "登陆成功..."
          redirect_to( :controller =>"topic",:action => "index")
        else
          flash[:notice]="对不起,您输入的账号和密码不匹配..."
          redirect_to(:action => "login")
        end
      end
  end

  def logout
    @user=User.find_by_id(session[:user_id])
    session[:user_id] = nil
    session[:user_group_id] = nil
    session[:group_id] = nil
    flash[:notice] ="欢迎您的光临,您已经成功登出,期待您的下次光临..."
    redirect_to(:controller=>"index",:action=>"index")
  end
  
  
  def find_pass
  end

  def register_class
    if request.get?
      @group=Group.new
    else
      @group = Group.new(params[:group])
      @group.created_at =Time.now
      @group.admin_id = session[:user_id]
      if @group.save
        @user=User.find_by_id(session[:user_id])
        @user.update_attribute('group_id',@group.id)
        redirect_to_index("班级 #{@group.title} 创建成功")
      end
    end
  end
  
  def join_class
      if request.get?
        @user = User.new
      else
        #@user=User.new(@params[:user])
        #group_id = @params['user','user_group_id']
        #@group_id = @params["photo"]
        @user=User.find_by_id(session[:user_id])
        if  @user.update_attributes(params[:user])
          flash[:notice] = '加入申请已经提交。请等待管理员审核...'
          session[:group_id] = @user.group_id
          redirect_to :action => 'index'
        else
          render :action => 'join_class'
        end
        #@user.update_attribute('group_id', group_id)
    end
  end
  
  #激活用户
  def confirm_email
    @users = User.find :all
    for user in @users
      # if the passed hash matches up with a User, confirm him, log him in, set proper flash[:notice], and stop looking
      if confirmation_hash(user.login_name) == params[:hash] # and !user.state
       # user.update_attributes(:state => 1)
        session[:user_id] = user.id
        session[:user_group_id] = user.user_group_id
        session[:group_id] = user.group_id
        flash[:notice] = "#{user.display_name},您已经成功激活您的账号..."
        break
      end
    end
 
    redirect_to(:controller=>"topic",:action=>"index")
  end
 
 
  private

  # create a hash to use when confirming User email addresses
  def confirmation_hash(string)
    Digest::SHA1.hexdigest(string + "byeloo")
  end
end
