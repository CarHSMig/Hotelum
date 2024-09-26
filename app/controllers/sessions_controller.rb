class SessionsController < ApplicationController
  def create
    @user = user.find_by(email: params[:email])

    if @user && @use.authenticate(params[:password])
      token = JsonWebToken.encode({ user_id: @user.id })
      render json: {token: token}, status: :ok
    else
      render json: { error: "Email ou senha inválidos" }, status: :unauthorized
    end
  end
end
