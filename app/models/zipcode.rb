# == Schema Information
#
# Table name: zipcodes
#
#  id           :bigint           not null, primary key
#  country_code :string
#  code         :string
#  name         :string
#  state        :string
#  city         :string
#  data         :jsonb
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_zipcodes_on_country_code           (country_code)
#  index_zipcodes_on_country_code_and_code  (country_code,code)
#
class Zipcode < ApplicationRecord
  validates :country_code, presence: true
  validates :code, presence: true, uniqueness: { scope: :country_code }
  validates :name, presence: true

  scope :country, ->(country_code) { where(country_code: country_code.to_s.upcase) }
  scope :ordered, -> { order(code: :asc) }

  before_validation do
    self.country_code = country_code.to_s.upcase
    self.code = code.to_s.downcase
  end

  class << self
    def cities
      ordered.uniq(&:city_full_name).select(&:present?).map do |zipcode|
        ::TyrObject.new(
          state_name: zipcode.state,
          name: zipcode.city,
          full_name: zipcode.city_full_name
        )
      end
    end
  end

  def full_name
    "#{city}#{name}"
  end

  def city_full_name
    "#{state}#{city}"
  end

  def to_h
    {
      zipcode: code,
      name: name,
      full_name: full_name,
      state_name: state,
      city_name: city
    }
  end
end
