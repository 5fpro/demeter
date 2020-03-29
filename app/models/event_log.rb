# == Schema Information
#
# Table name: event_logs
#
#  id          :bigint           not null, primary key
#  created_on  :date
#  data        :json
#  description :string
#  event_type  :string
#  identity    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_event_logs_on_created_on               (created_on)
#  index_event_logs_on_event_type               (event_type)
#  index_event_logs_on_event_type_and_identity  (event_type,identity)
#

class EventLog < Tyr::EventLog
end
