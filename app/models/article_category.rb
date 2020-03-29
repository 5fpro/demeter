# == Schema Information
#
# Table name: article_categories
#
#  id                     :bigint           not null, primary key
#  articles_count(文章數) :integer          default(0)
#  data                   :jsonb
#  deep(目前分層的深度)   :integer          default(0)
#  deleted_at             :datetime
#  enabled(是否顯示)      :boolean          default(TRUE)
#  layout(版位)           :string
#  name(名稱)             :string
#  sort(排序)             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  parent_id(上層分類)    :integer
#
# Indexes
#
#  index_article_categories_on_layout                       (layout)
#  index_article_categories_on_layout_and_deep              (layout,deep)
#  index_article_categories_on_layout_and_enabled           (layout,enabled)
#  index_article_categories_on_layout_and_enabled_and_sort  (layout,enabled,sort)
#  index_article_categories_on_layout_and_parent_id         (layout,parent_id)
#  trgm_article_categories_name_idx                         (name) USING gist
#

class ArticleCategory < Tyr::ArticleCategory
end
