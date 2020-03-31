# == Schema Information
#
# Table name: articles
#
#  id                                :bigint           not null, primary key
#  layout(版位)                      :string
#  article_category_id(文章分類)     :integer
#  subject(標題)                     :string
#  summary(摘要)                     :string
#  body(內文)                        :text
#  cover_id(封面照片，attachment id) :integer
#  published_on(發佈日期)            :date
#  published_at(發佈日期+時間)       :datetime
#  author_name(作者名稱)             :string
#  author_type                       :string
#  author_id                         :integer
#  status(狀態)                      :integer
#  top                               :boolean          default(FALSE)
#  meta_title(SEO 標題)              :string
#  meta_description(SEO 描述)        :string
#  meta_keywords(SEO 關鍵字)         :string
#  deleted_at                        :datetime
#  data                              :jsonb
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
# Indexes
#
#  index_articles_on_layout                                (layout)
#  index_articles_on_layout_and_article_category_id        (layout,article_category_id)
#  index_articles_on_layout_and_author_name                (layout,author_name)
#  index_articles_on_layout_and_author_type_and_author_id  (layout,author_type,author_id)
#  index_articles_on_layout_and_published_on               (layout,published_on)
#  index_articles_on_layout_and_status                     (layout,status)
#  index_articles_on_layout_and_top                        (layout,top)
#  trgm_articles_author_name_idx                           (author_name) USING gist
#  trgm_articles_body_idx                                  (body) USING gist
#  trgm_articles_subject_idx                               (subject) USING gist
#  trgm_articles_summary_idx                               (summary) USING gist
#
class Article < Tyr::Article
end
