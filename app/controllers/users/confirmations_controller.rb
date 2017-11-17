module Users
  class ConfirmationsController < Devise::ConfirmationsController
    # GET /resource/confirmation/new
    def new
      set_meta(title: '補寄認證信')
      super
    end

    # POST /resource/confirmation
    def create
      super do
        flash_if_has_error
      end
    end

    # GET /resource/confirmation?confirmation_token=abcdef
    # def show
    #   super
    # end

    # protected

    # The path used after resending confirmation instructions.
    # def after_resending_confirmation_instructions_path_for(resource_name)
    #   super(resource_name)
    # end

    # The path used after confirmation.
    # def after_confirmation_path_for(resource_name, resource)
    #   super(resource_name, resource)
    # end
  end
end
