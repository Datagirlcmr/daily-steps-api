class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.new(user_params)
    user.save!
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def update
    current_user.update!(user_params)
    json_response(current_user)
  end

  def show
    @result = user_profile
    json_response(@result)
  end

  private

  def user_profile
    result = {
      details: current_user
    }
    result
  end

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
