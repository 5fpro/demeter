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
require 'rails_helper'

RSpec.describe EventLog, type: :model do
  it do
    create(:event_log)
  end
end
