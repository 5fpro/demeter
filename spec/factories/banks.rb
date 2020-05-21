# == Schema Information
#
# Table name: banks
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :bank do
    code { 'MyString' }
    name { 'MyString' }
  end
end
