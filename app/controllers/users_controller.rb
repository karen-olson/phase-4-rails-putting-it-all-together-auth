class UsersController < ApplicationController
    wrap_parameters format: []

    def create 
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id 
            render json: user, status: :created
        else 
            render json: {error: "User must log in"}, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: :created
        else
          render json: {error: "User is not authorized"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
end
