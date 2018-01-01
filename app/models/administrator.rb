# == Schema Information
#
# Table name: administrators
#
#  id                     :integer          not null, primary key
#  name                   :string
#  root                   :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Administrator < ApplicationRecord
  devise :database_authenticatable, :trackable, :validatable, :async

  def gavatar_url(size = 50)
    Gavatar.new(email).to_s(size)
  end
end
