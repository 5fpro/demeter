module Admin
  class UserExporter < BaseExporter
    define_export(
      :id,
      :name,
      :email,
      :sign_in_count
    )
  end
end
