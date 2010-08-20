class MailRobot < ActionMailer::Base

  def confirmation_email(user,hash)
    # email header info MUST be added here
    @recipients = user.email
    @from = "iceskysl@163.com"
    @subject = "来自ByeLoo!的注册确认信.."

    # email body substitutions go here
    @body["username"] = user.login_name
    @body["diplay_name"] = user.display_name
    #
    @body["hash"] = hash
  end
  
    def notice_email(to,from)
    # email header info MUST be added here
    @recipients = to.email
    @from = "iceskysl@163.com"
    @subject = "请注意，您的朋友#{from.display_name}的联系方式有变.."

    # email body substitutions go here
    @body["username"] = to.display_name
    @body["email"] = from.email
    @body["mobile"] = from.mobile
    @body["display_name"] = from.display_name
    #
  end
  
end
