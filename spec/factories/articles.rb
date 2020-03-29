# == Schema Information
#
# Table name: articles
#
#  id                                :bigint           not null, primary key
#  author_name(作者名稱)             :string
#  author_type                       :string
#  body(內文)                        :text
#  data                              :jsonb
#  deleted_at                        :datetime
#  layout(版位)                      :string
#  meta_description(SEO 描述)        :string
#  meta_keywords(SEO 關鍵字)         :string
#  meta_title(SEO 標題)              :string
#  published_at(發佈日期+時間)       :datetime
#  published_on(發佈日期)            :date
#  status(狀態)                      :integer
#  subject(標題)                     :string
#  summary(摘要)                     :string
#  top                               :boolean          default(FALSE)
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  article_category_id(文章分類)     :integer
#  author_id                         :integer
#  cover_id(封面照片，attachment id) :integer
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

FactoryBot.define do
  factory :article do
    layout { 'default' }
    subject { 'haha' }
    summary { 'hahahaha' }
    body { 'hahahahahahhahaha' }
  end
end
