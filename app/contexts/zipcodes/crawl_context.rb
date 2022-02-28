module Zipcodes
  class CrawlContext < BaseContext
    def initialize(country_code)
      @country_code = country_code
    end

    def perform
      Zipcode.country(@country_code).delete_all
      send("crawl_for_#{@country_code.to_s.downcase}")
    end

    private

    def crawl_for_tw
      endpoint = 'https://gist.githubusercontent.com/abc873693/2804e64324eaaf26515281710e1792df/raw/a1e1fc17d04b47c564bbd9dba0d59a6a325ec7c1/taiwan_districts.json'
      cities = JSON.parse(Faraday.get(endpoint).body.force_encoding('utf-8'))
      cities.each do |city|
        city_name = city['name']
        city['districts'].each do |dist|
          next if dist['name'] == '釣魚臺'

          identity = "#{dist['zip']}#{dist['name']}"
          zipcode = Zipcode.find_or_initialize_by(country_code: 'TW', identity: identity)
          zipcode.update(city: city_name, name: dist['name'], code: dist['zip'])
        end
      end
    end

  end
end
