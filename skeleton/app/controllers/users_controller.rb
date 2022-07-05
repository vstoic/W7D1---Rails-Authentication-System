class UsersController < ApplicationController
    #redirects to index page if not logged in
    before_action :require_no_user!

    def index
        @users = User.all
        render :index
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            login_user!(@user)
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages,  status: :unprocessable_entity
        end
    end


    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end 