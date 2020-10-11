module Countries
  class CrawlRestcountriesContext < BaseContext
    def perform
      clear_data!
      all_raw_data.each do |hdata|
        country = Country.find_or_create_by(code: hdata['alpha2Code'].to_s)
        country.update(data: hdata)
      end
    end

    private

    def endpoint
      @endpoint ||= 'https://restcountries.eu/rest/v2/all'
    end

    def all_raw_data
      JSON.parse(Faraday.get(endpoint).body.force_encoding('utf-8'))
    end

    def clear_data!
      Country.connection.truncate(Country.table_name)
    end
  end
end
