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
class Country < ApplicationRecord
  validates :code, presence: true, uniqueness: true

  before_validation do
    self.code = code.to_s.upcase.tr(' ', '')
  end

  def to_h
    { id: code }.merge(data).with_indifferent_access
  end
end
