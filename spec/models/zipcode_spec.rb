# == Schema Information
#
# Table name: zipcodes
#
#  id             :bigint           not null, primary key
#  country_code   :string
#  code           :string
#  name           :string
#  state          :string
#  city           :string
#  data           :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  identity(識別) :string
#
# Indexes
#
#  index_zipcodes_on_country_code               (country_code)
#  index_zipcodes_on_country_code_and_code      (country_code,code)
#  index_zipcodes_on_country_code_and_identity  (country_code,identity)
#
require 'rails_helper'

RSpec.describe Zipcode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
