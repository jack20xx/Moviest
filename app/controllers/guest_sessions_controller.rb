class GuestSessionsController < ApplicationController
  def create
    user = User.find_or_create_by(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.activated = true
      user.activated_at = Time.zone.now
    end
      session[:user_id] = user.id
      flash[:success] = t('controllers.guest_sessions_controller.success')
      redirect_to root_url
  end
end
