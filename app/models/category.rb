# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  sort       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name)
#  index_categories_on_sort  (sort)
#

class Category < ApplicationRecord
  has_paper_trail only: [:name, :deleted_at, :sort]
  sortable column: :sort, add_new_at: nil
  restorable
  taggable

  validates :name, presence: true, uniqueness: true

end
