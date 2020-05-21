# == Schema Information
#
# Table name: branches
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  address    :string
#  bank_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Branch < ApplicationRecord
  validates :code, :name, presence: true
  validates :code, uniqueness: { scope: :bank_id }

  belongs_to :bank
  scope :same_bank, ->(bank) { where(bank: bank) }

  def to_h
    {
      branch_code: code,
      bank_branch_code: "#{bank.code}#{code}",
      address: address,
      name: name
    }
  end
end
