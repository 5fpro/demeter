module Api
  class BanksController < BaseController
    def index
      @banks = Bank.all
    end

    def branch_list
      @branches = Branch.all
    end
  end
end
