module Api
  class BanksController < BaseController
    def index
      @banks = Bank.all
      render json: @banks
    end

    def branch_list
      @branches = Branch.all
      render json: @branches
    end
  end
end