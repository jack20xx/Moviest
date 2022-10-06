class ResendActivationsController < ApplicationController
  before_action :get_user,         only: [:edit]

  def new
  end

  def create
    @user = User.find_by(email: params[:resend_activation][:email].downcase)
    if @user
      @user.resend_activation_digest
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      flash.now[:danger] = 'Email is not asociated with any account, please sign up first.'
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