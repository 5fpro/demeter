# == Schema Information
#
# Table name: attachments
#
#  id                :bigint           not null, primary key
#  creator_type      :string
#  data              :json
#  description       :text
#  file_content_type :string
#  file_size         :integer
#  image_exif        :json
#  image_height      :integer
#  image_width       :integer
#  item_type         :string
#  name              :string
#  original_filename :string
#  scope             :string
#  sort              :integer
#  stored_filename   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  creator_id        :integer
#  item_id           :integer
#
# Indexes
#
#  index_attachments_on_creator_type_and_creator_id               (creator_type,creator_id)
#  index_attachments_on_item_type_and_item_id                     (item_type,item_id)
#  index_attachments_on_item_type_and_item_id_and_scope           (item_type,item_id,scope)
#  index_attachments_on_item_type_and_item_id_and_scope_and_sort  (item_type,item_id,scope,sort)
#  index_attachments_on_item_type_and_item_id_and_sort            (item_type,item_id,sort)
#  trgm_attachments_description_idx                               (description) USING gist
#

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it do
    create(:attachment)
  end
end
