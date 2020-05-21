class BankBranchCheckScheduler < BaseScheduler
  def perform
    Fisc::Crawl.new.perform
  end
end
