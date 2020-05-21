class BankBranchCheckScheduler < BaseScheduler
  def perform
    Fisc::CrawlContext.new.perform
  end
end
