# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  sort       :integer
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
