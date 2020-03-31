# == Schema Information
#
# Table name: attachments
#
#  id                :bigint           not null, primary key
#  name              :string
#  description       :text
#  creator_type      :string
#  creator_id        :integer
#  item_type         :string
#  item_id           :integer
#  scope             :string
#  sort              :integer
#  original_filename :string
#  stored_filename   :string
#  file_content_type :string
#  file_size         :integer
#  image_width       :integer
#  image_height      :integer
#  image_exif        :json
#  data              :json
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
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
