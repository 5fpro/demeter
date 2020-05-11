require 'CSV'

module Fisc
  class Crawl
    def initialize(url)
      # https://www.fisc.com.tw/TC/OPENDATA/R2_Location.csv
      @url = url
    end

    def perform
      csv_content = Faraday.get(@url).body.force_encoding('utf-8')
      params = CSV.parse(csv_content, liberal_parsing: true, headers: true).map do |content|
        # <CSV::Row "銀行代號":"000" "分支機構代號":nil "金融機構名稱":"中央銀行國庫局" "分支機構名稱":nil "地址":"台北市中正區羅斯福路一段２號">
        if content[1].nil?
          parse_bank_data(content)
        else
          parse_branch_data(content)
        end
      end

      params.map do |param|
        find_update_or_create_bank(param) if param[:type] == 'bank'
        find_update_or_create_branch(param) if param[:type] == 'branch'
      end
    end

    private

    def parse_bank_data(data)
      {
        code: data[0],
        name: data[2],
        type: 'bank'
      }
    end

    def parse_branch_data(data)
      {
        bank_code: data[0],
        code: data[1],
        name: data[2],
        address: data[4],
        type: 'branch'
      }
    end

    def find_update_or_create_bank(bank_params)
      code = bank_params[:code]
      return if code.blank?

      type = bank_params.delete(:type)
      bank = Bank.find_or_initialize_by(code: code)
      save_data(bank, bank_params, type)
    end

    def find_update_or_create_branch(branch_params)
      code = branch_params[:code]
      bank = Bank.find_by(code: branch_params[:bank_code])
      return if code.blank?

      type = branch_params.delete(:type)
      branch_params.delete(:bank_code)
      branch_params.merge!(bank: bank)
      branch = Branch.same_bank(bank).find_or_initialize_by(code: code)
      save_data(branch, branch_params, type)
    end

    def save_data(data, params, type)
      data.assign_attributes(params)
      if data.new_record?
        ::Tyr::LogEventContext.new("create_#{type}", identity: data.id, data: params).perform if data.save
      else
        data.save
        ::Tyr::LogEventContext.new("update_#{type}", identity: data.id, data: params, description: data.saved_changes).perform if data.saved_changes.present?
      end
      ::Tyr::LogEventContext.new("#{type}_error_detail", identity: data.id, data: params, description: data.errors.full_messages.to_sentence).perform if data.errors.any?
    end
  end
end
