class UsersController < ApplicationController
    # redirects to index page if not logged in
    before_action :require_logged_out

    def index
        @users = User.all
        render :index
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            login_user!(@user)
            redirect_to cats_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end 