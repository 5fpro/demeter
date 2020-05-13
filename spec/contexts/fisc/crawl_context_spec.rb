require 'rails_helper'

describe Fisc::CrawlContext, type: :context do
  it 'will update bank and branch information' do
    described_class.new.perform
    expect(Bank.count).to eq(11)
    expect(Branch.count).to eq(40)
    expect(EventLog.where(event_type: 'bank_not_found').count).to eq(1)
    expect(EventLog.count).to eq(52)
    expect(Bank.first.name).to eq('中央銀行國庫局')
    expect(Branch.first.name).to eq('國庫局')
  end
end