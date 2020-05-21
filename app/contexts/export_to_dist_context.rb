class ExportToDistContext < BaseContext
  def initialize(dir = 'dist')
    @dir = Rails.root.join(dir)
  end

  def perform
    `rm -rf #{@dir.join('banks')}`
    IO.write(@dir.join('banks.json'), Bank.all.map(&:to_h).to_json)
    branch_dir = @dir.join('banks')
    `mkdir -p #{branch_dir}`
    Bank.find_each do |bank|
      IO.write(branch_dir.join("#{bank.code}.json"), { bank: bank.to_h, branches: bank.branches.map(&:to_h) }.to_json)
    end
  end

end
