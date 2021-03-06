# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def new
    if @user.save
      redirect_to user_path(user.id)
      flash[:notice] = 'Signed in successfully.'
    else
      render :new
    end
  end

  
  def destroy
    @user.destroy
    redirect_to destroy_user_session_path
    flash[:notice] = 'Signed out successfully.'
  end
end