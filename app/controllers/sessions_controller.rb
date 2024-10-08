# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password]) && user&.is_active
      log_in user
      redirect_to posts_path, notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path, notice: 'Logged out successfully'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
