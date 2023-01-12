module Crawlers
  class TwIdnetityPlaceContext < BaseContext
    def perform
      body = Faraday.get(endpoint).body.force_encoding('utf-8')
      data = {}
      body.match(/name="siteId".+?>(.+?)<\/select>/m)[1]&.scan(/<option value="(.+?)">(.+?)<\/option>/).each do |matches|
        next if matches[0] == '0'

        data[matches[0]] = matches[1]
      end
      data
    end

    private

    def endpoint
      @endpoint ||= 'https://www.ris.gov.tw/apply-idCard/app/idcard/IDCardReissue/main'
    end
  end
end
