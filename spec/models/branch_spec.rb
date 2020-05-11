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
require 'rails_helper'

RSpec.describe Branch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
