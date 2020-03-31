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
class Admin::Category < ::Category

  class << self
    def ransackable_scopes(_auth_object = nil)
      [:delete_state, :tagged]
    end
  end
end
