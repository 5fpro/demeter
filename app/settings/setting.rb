class Setting < Settingslogic
  source Rails.root.join('config', 'application.yml')
  namespace Rails.env
end
