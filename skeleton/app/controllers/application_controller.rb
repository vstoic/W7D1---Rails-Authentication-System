class ApplicationController < ActionController::Base
    # skip_before_action :verify_authenticity_token

    #Makes the current_user & logged_in? controller method available in views
    helper_method :current_user, :logged_in?
    
    private
    #Redirect user to the cats index if the user tries to visit the login/signup pages when they're already signed in
    def require_logged_out
        redirect_to cats_url if logged_in?
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end
    #resets session token
    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    #Helper method for SessionController #destroy
    def logout!
        current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        @current_user = nil
    end
end
