# == Schema Information
#
# Table name: activities
#
#  id          :bigint           not null, primary key
#  actor_type  :string
#  actor_id    :integer
#  action      :string
#  target_type :string
#  target_id   :integer
#  acted_on    :date
#  data        :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_activities_on_acted_on                   (acted_on)
#  index_activities_on_action                     (action)
#  index_activities_on_actor_type_and_actor_id    (actor_type,actor_id)
#  index_activities_on_target_type_and_target_id  (target_type,target_id)
#
require 'rails_helper'

RSpec.describe Activity, type: :model do
  it do
    create(:activity)
  end
end
