module Api
  class BanksController < BaseController
    def index
      @banks = Bank.all
    end

    def branches
      @branches = Bank.find_by(code: params[:id]).branches
    end
  end
end
