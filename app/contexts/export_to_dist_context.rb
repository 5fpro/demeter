class ExportToDistContext < BaseContext
  def initialize(dir = 'dist')
    @dir = Rails.root.join(dir)
  end

  def perform
    # export_banks!
    export_countries!
  end

  private

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
end
