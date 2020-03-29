# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  body          :string
#  created_on    :date
#  data          :json
#  notify_type   :string
#  object_type   :string
#  readed        :boolean          default(FALSE)
#  receiver_type :string
#  sender_type   :string
#  subject       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  object_id     :string
#  receiver_id   :string
#  sender_id     :string
#
# Indexes
#
#  index_notifications_on_created_on                                (created_on)
#  index_notifications_on_notify_type                               (notify_type)
#  index_notifications_on_object_type_and_object_id                 (object_type,object_id)
#  index_notifications_on_readed_and_receiver_type_and_receiver_id  (readed,receiver_type,receiver_id)
#  index_notifications_on_receiver_type_and_receiver_id             (receiver_type,receiver_id)
#  index_notifications_on_sender_type_and_sender_id                 (sender_type,sender_id)
#  trgm_notifications_body_idx                                      (body) USING gist
#  trgm_notifications_subject_idx                                   (subject) USING gist
#

class Notification < Tyr::Notification
end
