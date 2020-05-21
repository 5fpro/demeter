module Api
  class BanksController < BaseController
    def index
      @banks = Bank.all
      render json: @banks.map(&:to_h)
    end

    def branches
      @branches = Bank.find_by(code: params[:id]).branches
      render json: @branches.map(&:to_h)
    end
  end
end
