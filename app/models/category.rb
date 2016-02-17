# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  sort       :integer
#

class Category < ActiveRecord::Base
  has_paper_trail only: [ :name, :deleted_at, :sort ]
  sortable column: :sort, add_new_at: nil
  restorable
  taggable

  validates_presence_of :name
  validates_uniqueness_of :name

end
