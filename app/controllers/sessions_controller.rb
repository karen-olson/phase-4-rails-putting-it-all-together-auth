class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created 
            # how to render an array of messages when the result of User.find_by is nil? 
            # is there a way to make the return value of that query false instead of nil? 
        else
            render json: {error: "Invalid username or password"}, status: :unauthorized
        end
    end

    def destroy 
        if session[:user_id]
            session.delete :user_id 
            head :no_content
        else 
            render json: {error: "No users are logged in"}, status: :unauthorized
            # asking for an array of error messages again - not sure where these would come from in this case
        end
    end
end
