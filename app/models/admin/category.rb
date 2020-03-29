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

class Admin::Category < ::Category

  class << self
    def ransackable_scopes(_auth_object = nil)
      [:delete_state, :tagged]
    end
  end
end
