# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).confirmation_email.deliver_now
      redirect_to root_path, notice: 'Please check your email to confirm your account.'
    else
      render :new
    end
  end

  def confirm
    user = User.find_by(confirmation_token: params[:token])
    if user&.confirmation_token_valid?
      user.confirm!
      redirect_to login_path, notice: 'Your account has been confirmed. Please log in.'
    else
      redirect_to login_path, alert: 'Invalid or expired token.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :password_confirmation)
  end
end
