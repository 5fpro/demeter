class ExportToDistContext < BaseContext
  def initialize(dir = 'dist')
    @dir = Rails.root.join(dir)
  end

  def perform
    export_index!
    export_banks!
    export_countries!
    export_zipcodes!
    export_zipcodes_js!
    export_tw_identity_places!
  end

  private

  def export_zipcodes_js!
    source = Rails.root.join('app/assets/javascripts/zipcode-selector.js')
    target = @dir.join('tw/zipcode-selector.js')
    content = IO.read(source)
    IO.write(target, Uglifier.compile(content, harmony: true))
  end

  def export_index!
    IO.write(@dir.join('index.html'), '<script>location.href="/index.json";</script>')
    index_data = {
      bank: "#{production_url}/banks.json",
      country: {
        all: "#{production_url}/countries.json",
        one: {
          format: "#{production_url}/country/{country_code}.json",
          examples: [
            "#{production_url}/country/TW.json",
            "#{production_url}/country/JP.json"
          ]
        }
      },
      zipcode: {
        country: {
          format: "#{production_url}/{country_code(lower case)}/zipcode{type}.json",
          types: {
            all: "#{production_url}/tw/zipcodes.json",
            cities: "#{production_url}/tw/zipcode/cities.json"
          }
        },
        city: {
          format: "#{production_url}/{country_code(lower case)}/zipcode/{city_name}.json",
          examples: [
            "#{production_url}/tw/zipcode/臺北市.json",
            "#{production_url}/tw/zipcode/臺南市.json"
          ]
        }
      }
    }
    IO.write(@dir.join('index.json'), index_data.to_json)
  end

  def production_url
    'https://demeter.5fpro.com'
  end

  def export_banks!
    `rm -rf #{@dir.join('banks')}`
    IO.write(@dir.join('banks.json'), Bank.all.map { |b| b.to_h.merge(branches_endpoint: "#{production_url}/banks/#{b.code}.json") }.to_json)
    branch_dir = @dir.join('banks')
    `mkdir -p #{branch_dir}`
    Bank.find_each do |bank|
      IO.write(branch_dir.join("#{bank.code}.json"), { bank: bank.to_h, branches: bank.branches.map(&:to_h) }.to_json)
    end
  end

  def export_countries!
    `rm -rf #{@dir.join('country')}`
    `rm -rf #{@dir.join('countries.json')}`
    IO.write(@dir.join('countries.json'), Country.all.map { |c| c.to_h.merge(endpoint: "#{production_url}/country/#{c.code}.json") }.to_json)
    branch_dir = @dir.join('country')
    `mkdir -p #{branch_dir}`
    Country.find_each do |country|
      IO.write(branch_dir.join("#{country.code.upcase}.json"), country.to_h.to_json)
    end
  end

  def export_zipcodes!
    `cp #{Rails.root.join('app/assets/javascripts/zipcode-selector.js')} #{@dir.join('/')}`
    Country.find_each do |country|
      country_code = country.code.to_s.downcase
      country_dir = @dir.join(country_code)
      `mkdir -p #{country_dir}`
      `rm -rf #{country_dir.join('zipcode')}`
      `mkdir -p #{country_dir.join('zipcode')}`
      zipcodes_file = country_dir.join('zipcodes.json')
      IO.write(zipcodes_file, Zipcode.country(country_code).ordered.map(&:to_h).to_json)
      cities_file = country_dir.join('zipcode', 'cities.json')
      cities = Zipcode.country(country_code).cities
      IO.write(cities_file, cities.map { |city| city.to_h.merge(zipcodes_endpoint: "#{production_url}/#{country_code}/zipcode/#{CGI.escape(city.full_name)}.json") }.to_json)
      cities.each do |city|
        IO.write(country_dir.join('zipcode', "#{city.full_name}.json"), Zipcode.country(country_code).where(city: city.name, state: city.state).ordered.map(&:to_h).to_json)
      end
    end
  end

  def export_tw_identity_places!
    data = ::Crawlers::TwIdnetityPlaceContext.new.perform.to_a.map do |arr|
      {
        id: arr.first,
        label: arr.last
      }
    end
    IO.write(@dir.join('tw', 'identity_places.json'), { places: data }.to_json)
  end
end
