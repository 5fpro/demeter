# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  sender_type   :string
#  sender_id     :string
#  receiver_type :string
#  receiver_id   :string
#  object_type   :string
#  object_id     :string
#  notify_type   :string
#  readed        :boolean          default(FALSE)
#  subject       :string
#  body          :string
#  created_on    :date
#  data          :json
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
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
