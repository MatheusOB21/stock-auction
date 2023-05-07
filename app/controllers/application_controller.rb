class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf])
    end

    def admin_page 
      if current_user.is_admin 
      else
        redirect_to root_path, notice:  "Você não tem acesso a essa página"
      end
    end

end
