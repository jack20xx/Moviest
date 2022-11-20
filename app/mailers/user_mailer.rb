class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウントの認証(Account activation)"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードの再設定(Password reset)"
  end
end
