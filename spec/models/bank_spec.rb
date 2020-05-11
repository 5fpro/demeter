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
require 'rails_helper'

RSpec.describe Bank, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
