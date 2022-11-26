class ResendActivationsController < ApplicationController
  before_action :get_user,         only: [:edit]

  def new
  end

  def create
    @user = User.find_by(email: params[:resend_activation][:email].downcase)
    if @user 
      if @user.activated? then
        flash.now[:danger] = t('controllers.resend_activations_controller.danger1')
        render 'new'
      elsif !@user.activated? then
        @user.resend_activation_digest
        @user.send_activation_email
        flash[:info] = t('controllers.resend_activations_controller.info')
        redirect_to root_url
      end
    else
      flash.now[:danger] = t('controllers.resend_activations_controller.danger2')
      render 'new'
    end
  end

  def edit
  end

  private
    def get_user
      @user = User.find_by(email: params[:email])
    end
end