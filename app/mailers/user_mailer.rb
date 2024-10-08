# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def confirmation_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Confirm your account')
  end
end
