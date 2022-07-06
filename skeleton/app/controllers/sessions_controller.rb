class SessionsController < ApplicationController
    before_action :require_logged_out

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        #verifys the username and password through the hash 
        if @user
          login_user!(@user)
          redirect_to user_url(@user)
        else
          render :new
        end
    end

    #logout! resets session token on current user
    def destroy
      logout!
      redirect_to new_session_url
    end
end