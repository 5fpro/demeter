class BaseController < ApplicationController
  before_action :set_meta

  def index; end

  def not_found
    render status: :not_found
  end
end
