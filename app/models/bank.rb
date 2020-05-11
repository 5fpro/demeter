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
class Bank < ApplicationRecord
  validates :code, :name, presence: true
  validates :code, uniqueness: true

  has_many :branches, dependent: :destroy
end
