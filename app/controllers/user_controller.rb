require "digest/sha1"
class UserController < ApplicationController
  before_filter :authorize
  layout "topic"
  
  def profile
  @user = User.find(session[:user_id])
  end
  
    def upload 
    @user = User.new(params[:user])
    filename = SingleFile.save(params["user"])
    @photo.url= SingleFile.path
    @photo.simple_path= SingleFile.simple_path
    @photo.content_type= SingleFile.content_type
    if @photo.save
      flash[:notice] = '恭喜,恭喜,照片上传成功.'
      redirect_to :controller =>"topic",:action => "index"
    else
      redirect_to :action => 'new'
    end
  end
  
  def update_profile
    #@user = User.new(params[:user])
    @user = User.find(session[:user_id])
    email=@user.email
    mobile=@user.mobile
    @users = User.find(:all,:conditions => "group_id = #{session[:group_id]}")
    if @user.update_attributes(params[:user])
      if email != @user.email || mobile != @user.mobile
        for to in @users 
          MailRobot::deliver_notice_email(to, @user)
        end
        flash[:notice] = '资料修改成功，并通知了您的朋友...'
      else
        flash[:notice] = '资料修改成功...'
      end
      redirect_to :controller =>"topic",:action => "index"
    else
      render :action => 'profile'
    end
  end
  
  def password
  #@user = User.new
  end
  
  def update_password
        old_password = params[:user][:old_password]
        new_password = params[:user][:new_password]
        new_password_confirm = params[:user][:new_password_confirm]
        if (new_password==new_password_confirm)
        #logged_in_user = @user.try_to_login
          @user = User.find(session[:user_id])
          can_log_in = User.can_login(session[:user_id],old_password)
          if can_log_in
            session[:user_id]=can_log_in.id
            session[:user_group_id] = can_log_in.user_group_id
            session[:group_id] = can_log_in.group_id
            @user.update_attribute('hashed_pass', Digest::SHA1.hexdigest(new_password || ""))
            flash[:notic] = "密码更新成功..."
            redirect_to( :controller =>"topic",:action => "index")
          else
            flash[:notice]="对不起,您输入的原始密码不正确，请确认..."
            redirect_to(:action => "password")
          end
        else
          flash[:notice]="你两次输入的新密码不一致，请确认..."
          redirect_to(:action => "password")
        end

  end
  
end
