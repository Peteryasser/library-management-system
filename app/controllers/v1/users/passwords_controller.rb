# frozen_string_literal: true

class V1::Users::PasswordsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def edit
    if current_user
      otp = current_user.generate_otp
      UserMailer.otp_email(current_user, current_user.email, otp).deliver_now

      render json: { message: 'OTP sent to your email' }, status: :ok
    else
      render json: { errors: 'Email not found' }, status: :not_found
    end
  end

  def update
    if current_user.verify_otp(params[:otp])
      
      if current_user.update(password_reset_params)
        render json: { message: 'Password updated successfully' }, status: :ok
      else
        render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Invalid OTP' }, status: :unauthorized
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end 

  # def create
  #   self.resource = resource_class.send_reset_password_instructions(reset_password_params)
  #   if successfully_sent?(resource)
  #     render json: { message: "Reset password instructions sent." }, status: :ok
  #   else
  #     render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /v1/users/password
  # def update
  #   self.resource = resource_class.reset_password_by_token(reset_password_params)
  #   if resource.errors.empty?
  #     render json: { message: "Password has been reset successfully." }, status: :ok
  #   else
  #     render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end



  private def create
    build_resource(sign_up_params)
    resource.status="signout"
    resource.save
    if resource.persisted?
        send_confirmation_email(resource)
        render json: { message: 'Signed up successfully. Please check your email to confirm your account.' }, status: :created
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end


  # Permit parameters for reset password request
  def reset_password_params
    params.require(:user).permit(:email, :reset_password_token, :password, :password_confirmation)
  end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
