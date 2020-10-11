# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  code       :string
#  data       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_countries_on_code  (code)
#
require 'rails_helper'

RSpec.describe Country, type: :model do
end
