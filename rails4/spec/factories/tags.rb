# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string
#  taggings_count :integer          default(0)
#

FactoryGirl.define do
  factory :tag do

  end

end
