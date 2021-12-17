class RecipesController < ApplicationController
    before_action :authorize
    wrap_parameters format: []

    def index 
        render json: Recipe.all
    end

    def create 
        user = User.find_by(id: session[:user_id])
        recipe = user&.recipes.new(recipe_params)
        if recipe.save 
            render json: recipe, status: :created
        else
            render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private 

    def authorize
        render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id 
    end

    def recipe_params 
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end
end
