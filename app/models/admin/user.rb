# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class Admin::User < ::User

  class << self
    def ransackable_scopes(_auth_object = nil)
      [:has_avatar]
    end

    def has_avatar(_boolean = true)
      where.not(avatar: nil)
    end

    def to_csv(opts = {})
      CSV.generate(opts) do |csv|
        csv << ['ID', 'Name', 'Email']
        offset(0).limit(relation.count).all.find_each do |o| # reset pagination
          csv << [o.id, o.name, o.email]
        end
      end
    end
  end

end
