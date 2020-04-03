module Admin
  class UsersController < ::Admin::BaseController
    before_action :user
    before_action :set_default_breadcrumb
    before_action only: [:show, :edit] do
      add_breadcrumb(@user.label, admin_user_path(@user))
    end

    def index
      @q = Admin::User.ransack(params[:q_user])
      @users = @q.result.order(id: :desc).page(params[:page]).per(30)
      respond_with @users, exporter: 'Admin::UserExporter'
    end

    def show
      set_meta(title: locale_vars)
    end

    def new
      self.action_name = 'new'
      set_meta
      add_breadcrumb t('.breadcrumb')
    end

    def edit
      self.action_name = 'edit'
      set_meta(title: locale_vars)
      add_breadcrumb t('.breadcrumb')
    end

    def create
      if user.save
        redirect_to params[:redirect_to] || admin_user_path(user), flash: { success: t('.success', locale_vars) }
      else
        new
        flash.now[:error] = user.errors.full_messages
        render :new
      end
    end

    def update
      if user.update(user_params)
        redirect_to params[:redirect_to] || admin_user_path(user), flash: { success: t('.success', locale_vars) }
      else
        edit
        flash.now[:error] = user.errors.full_messages
        render :edit
      end
    end

    def destroy
      if user.destroy
        redirect_to params[:redirect_to] || admin_users_path, flash: { success: t('.success', locale_vars) }
      else
        redirect_to :back, flash: { error: user.errors.full_messages }
      end
    end

    private

    def user
      @user ||= params[:id] ? Admin::User.find(params[:id]) : Admin::User.new(user_params)
    end

    def user_params
      params.fetch(:user, {}).permit!
    end

    def locale_vars
      {
        label: user.label
      }
    end
  end
end
