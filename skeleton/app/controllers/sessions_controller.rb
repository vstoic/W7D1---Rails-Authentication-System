class SessionsController < ApplicationController
    before_action :require_no_user!, only: %i(create new)

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

        if @user
          login_user!(@user)
          redirect_to user_url(@user)
        else
          render :new
        end
    end

    def destroy
      logout!
      redirect_to new_session_url
    end
end