# == Schema Information
#
# Table name: event_logs
#
#  id          :bigint           not null, primary key
#  event_type  :string
#  description :string
#  identity    :string
#  created_on  :date
#  data        :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_event_logs_on_created_on               (created_on)
#  index_event_logs_on_event_type               (event_type)
#  index_event_logs_on_event_type_and_identity  (event_type,identity)
#
FactoryBot.define do
  factory :event_log do
    event_type { :test }
    sequence(:identity) { |n| "123-#{n}" }
  end
end
