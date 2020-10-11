class ExportToDistContext < BaseContext
  def initialize(dir = 'dist')
    @dir = Rails.root.join(dir)
  end

  def perform
    # export_banks!
    # export_countries!
    export_zipcodes!
  end

  private

  def production_url
    'https://demeter.5fpro.com'
  end

  def export_banks!
    `rm -rf #{@dir.join('banks')}`
    IO.write(@dir.join('banks.json'), Bank.all.map(&:to_h).to_json)
    branch_dir = @dir.join('banks')
    `mkdir -p #{branch_dir}`
    Bank.find_each do |bank|
      IO.write(branch_dir.join("#{bank.code}.json"), { bank: bank.to_h, branches: bank.branches.map(&:to_h) }.to_json)
    end
  end

  def export_countries!
    `rm -rf #{@dir.join('country')}`
    `rm -rf #{@dir.join('countries.json')}`
    IO.write(@dir.join('countries.json'), Country.all.map(&:to_h).to_json)
    branch_dir = @dir.join('country')
    `mkdir -p #{branch_dir}`
    Country.find_each do |country|
      IO.write(branch_dir.join("#{country.code.upcase}.json"), country.to_h.to_json)
    end
  end

  def export_zipcodes!
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
end
