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
FactoryBot.define do
  factory :branch do
    code { 'MyString' }
    name { 'MyString' }
    address { 'MyString' }
  end
end
