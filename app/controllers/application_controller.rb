class ApplicationController < ActionController::Base
    before_action :configure_parmitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        posts_path
    end

    def autheniticate_user
        if @current_user == nil
            flash[:notice]="ログインが必要です"
            redirect_to new_user_session_path
        end
    end

    protected

    def configure_parmitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    end
end

