# frozen_string_literal: true

class V1::Users::SessionsController < ApplicationController

  before_action :authenticate_user!, only: [:destroy] 
  before_action :check_confirmation, only: [:create]

  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      token = JsonWebToken.encode(user_id: user.id)
      user.update(status: "signin")
      render json: { token: token, user: user.as_json(only: [:id, :user_name, :email, :name, :role, :status]) }, status: :ok
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end 
  end

  def destroy
    token = request.headers['Authorization'].split(' ').last
    decoded_token = JsonWebToken.decode(token)
    if decoded_token
      jti = decoded_token['jti']
      TokenBlacklist.create(jti: jti, exp: Time.at(decoded_token['exp']))
    end
    current_user.update(status: "signout")
    head :no_content
  end

  def check_confirmation
    user = User.find_by(email: params[:user][:email])
    if user && !user.otp_verified?
      render json: { errors: 'Please confirm your email address before signing in.' }, status: :unauthorized
    end
  end

  # before_action :configure_s  ign_in_params, only: [:create]

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
end
